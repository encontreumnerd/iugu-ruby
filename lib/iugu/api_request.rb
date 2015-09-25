require 'excon'
require 'base64'
require 'json'

module Iugu
  # Handle all requests
  class APIRequest
    def self.request(method, url, data = {}, authorization_token = nil)
      Iugu::Utils.auth_from_env if Iugu.api_key.nil?
      fail Iugu::AuthenticationException, 'API Key not set' if Iugu.api_key.nil?
      handle_response send_request(method, url, data, authorization_token)
    end

    # private

    def self.send_request(method, url, data, authorization_token)
      m = Excon.method(method.downcase)
      m.call(url, build_request(data, authorization_token))
    end

    def self.build_request(data, authorization_token)
      data = data.to_json unless data[:multipart]
      {
        verify_ssl: true,
        headers: default_headers(authorization_token),
        payload: data,
        timeout: 30
      }
    end

    def self.handle_response(response)
      response_json = JSON.parse(response.body)
      if response_json.is_a?(Hash) && response_json['errors'] == 'Not Found'
        fail ObjectNotFound
      end
      if response_json.is_a?(Hash) && response_json['errors'] && response_json['errors'].length > 0
        fail RequestWithErrors, response_json['errors']
      end
      response_json
    rescue JSON::ParserError
      raise RequestFailed
    end

    def self.default_headers(authorization_token)
      token = authorization_token || Iugu.api_key
      {
        authorization: 'Basic ' + Base64.encode64(token + ":"),
        accept: 'application/json',
        accept_charset: 'utf-8',
        user_agent: 'Iugu RubyLibrary',
        accept_language: 'pt-br;q=0.9,pt-BR',
        # content_type: 'application/x-www-form-urlencoded; charset=utf-8'
        content_type: 'application/json; charset=utf-8'
      }
    end

  end
end

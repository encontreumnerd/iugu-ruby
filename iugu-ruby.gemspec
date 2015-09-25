lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iugu/version'

Gem::Specification.new do |spec|
  spec.name          = 'iugu-ruby'
  spec.version       = Iugu::VERSION
  spec.authors       = ['Marcelo Paez Sequeira', 'João Pedro Netto']
  spec.email         = ['marcelo@iugu.com', 'hi@joaonetto.me']
  spec.summary       = 'Iugu API'
  spec.homepage      = 'https://iugu.com/referencias/api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # spec.add_dependency 'rest-client'
  spec.add_dependency 'excon'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake'
end

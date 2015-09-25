# Iugu API Ruby

    gem 'iugu-ruby', github: 'encontreumnerd/iugu-ruby'


## Examples

    Iugu.api_key = 'YOUR_API_TOKEN'

    # Exemplo de cobrança direta de CC em Ruby
    Iugu::Charge.create(
      token: 'iugu.js generated token',
      email: 'customers_email',
      months: '1'
      items: [
        {
          description: 'Item Teste',
          quantity: 1,
          price_cents: 1000
        }
      ]
    )

    # Exemplo de Gestão de Assinaturas em meia dúzia de linhas. Com direito a pagamento recorrente via Cartão ou Boleto. No caso de Cartão, recomenda-se vincular um token ao customer (Default Payment Method).
    customer = Iugu::Customer.create({
          "email"=>"EMAIL DO CLIENTE",
          "name"=>"NOME DO CLIENTE"
    })

    subscription = Iugu::Subscription.create({
    "plan_identifier" => "basic_plan", "customer_id" => customer.id
    })

    # Exemplo de Downgrade/Upgrade de Conta (Com cálculo automático de diferença de valores entre planos, créditos, etc)
    subscription.change_plan( "novo_plano" );

    # Histórico de Pagamentos do Cliente
    customer.invoices

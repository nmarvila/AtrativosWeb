FactoryBot.define do
  factory :pj do
    cnpj { "00000000000000" }
    razao_social { "MyString" }
    nome_fantasia { "MyString" }
    email { "MyString" }
    senha { "MyString" }
    esta_ativa { true }
  end
end
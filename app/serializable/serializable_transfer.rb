class SerializableTransfer < JSONAPI::Serializable::Resource
  type 'transfers'

  id { nil }

  attributes :account_number_from, :account_number_to, :amount_pennies,
  :country_code_from, :country_code_to

end

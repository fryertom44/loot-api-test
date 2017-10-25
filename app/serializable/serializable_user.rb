class SerializableUser < JSONAPI::Serializable::Resource
  type 'users'

  id { nil }
  
  attribute :name do
    [@object.first_name, @object.last_name].join(" ")
  end

  attribute :age do
    dob = @object.dob
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end

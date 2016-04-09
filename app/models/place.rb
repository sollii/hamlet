class Place < Sequel::Model
  many_to_one :address
  plugin :class_table_inheritance, key: :place_type

  def add_address(params)
    address = Address.create params
    self.update address: address
  end

end

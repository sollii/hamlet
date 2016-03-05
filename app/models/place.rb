class Place < Sequel::Model
  many_to_one :address
  plugin :class_table_inheritance, key: :place_type
end

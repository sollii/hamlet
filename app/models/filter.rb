class Filter < Sequel::Model
  plugin :class_table_inheritance, key: :place_type
  many_to_one :user
end

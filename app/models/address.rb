class Address < Sequel::Model
  one_to_many :place
end

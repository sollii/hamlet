class Filter < Sequel::Model
  plugin :class_table_inheritance, key: :filter_type
  many_to_one :user

  def filter(listings)
    listings
  end
end

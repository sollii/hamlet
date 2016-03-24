Sequel.migration do
  change do

    create_table :area_filters do
      primary_key :id
      String :name
      foreign_key :address_id, :addresses
    end

  end
end

Sequel.migration do
  change do

    create_table :places do
      primary_key :id
      foreign_key :address_id, :addresses
      String :place_type, null: false
    end

  end
end

Sequel.migration do
  change do

    create_table :parks do
      primary_key :id
      String :name
      String :address
      Float :park_area
      Float :lat
      Float :lon
    end

  end
end

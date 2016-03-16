Sequel.migration do
  change do

    create_table :city_parks_filters do
      primary_key :id
      String :park_names
      String :distance_to_park
    end

  end
end

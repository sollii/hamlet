Sequel.migration do
  change do

    create_table :home_characteristics_filters do
      primary_key :id
      String :bedrooms
      String :bathrooms
      String :sq_footage
    end

  end
end

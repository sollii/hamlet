Sequel.migration do
  change do

    create_table :home_characteristics_filters do
      primary_key :id
      String :bedrooms, :default => ""
      String :bathrooms, :default => ""
      String :sq_footage, :default => "0"
    end

  end
end

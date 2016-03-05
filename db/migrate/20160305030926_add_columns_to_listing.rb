Sequel.migration do
  change do
    alter_table :listings do
      add_column :bedrooms, Float, :default=>0
      add_column :bathrooms, Float, :default=>0
      add_column :sq_footage, Integer, :default=>0
      add_column :year, Integer, :default=>0
      add_column :price, Integer, :default=>0
    end
  end
end

class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :neighborhood
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :sq_footage
      t.integer :lot_footage
      t.string :housing_style
      t.string :description
      t.string :property_type
      t.integer :year
      t.integer :price_per_sqft
      t.integer :tax_valuation
      t.integer :taxes
      t.integer :land_value
      t.integer :additions

      t.timestamps null: false
    end
  end
end

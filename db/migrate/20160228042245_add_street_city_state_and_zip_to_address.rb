class AddStreetCityStateAndZipToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :street, :string
    add_column :addresses, :city, :string
    add_column :addresses, :state, :string
    add_column :addresses, :zip, :string
  end
end

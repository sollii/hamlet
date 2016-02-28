class AddListingAsPlaceSubclass < ActiveRecord::Migration
  def change
    add_column :places, :type, :string
  end
end

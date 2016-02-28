class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.references :address, index: true

      t.timestamps null: false
    end
    add_foreign_key :places, :addresses
  end
end

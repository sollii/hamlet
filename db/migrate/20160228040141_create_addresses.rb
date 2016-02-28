class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :text
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end

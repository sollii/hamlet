class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.references :address, index: true
      t.integer :rating
      t.integer :gsid
      t.integer :parent_rating

      t.timestamps null: false
    end
    add_foreign_key :schools, :addresses
  end
end

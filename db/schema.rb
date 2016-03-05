Sequel.migration do
  change do
    create_table(:addresses) do
      primary_key :id
      column :lat, "double precision"
      column :lng, "double precision"
      column :street, "varchar(255)"
      column :city, "varchar(255)"
      column :state, "varchar(255)"
      column :zip, "integer"
    end
    
    create_table(:schema_migrations) do
      column :filename, "varchar(255)", :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:users) do
      primary_key :id
      column :email, "varchar(255)", :default=>"", :null=>false
      column :encrypted_password, "varchar(255)", :default=>"", :null=>false
      column :reset_password_token, "varchar(255)"
      column :reset_password_sent_at, "varchar(255)"
      column :remember_created_at, "timestamp"
      column :sign_in_count, "integer", :default=>0, :null=>false
      column :current_sign_in_at, "timestamp"
      column :last_sign_in_at, "timestamp"
      column :current_sign_in_ip, "varchar(255)"
      column :last_sign_in_ip, "varchar(255)"
      column :created_at, "timestamp"
      column :updated_at, "timestamp"
      
      index [:email], :unique=>true
      index [:reset_password_token], :unique=>true
    end
    
    create_table(:filters) do
      primary_key :id
      foreign_key :user_id, :users
      column :function, "varchar(255)"
      column :filter_type, "varchar(255)", :null=>false
      column :precedence, "integer"
    end
    
    create_table(:places) do
      primary_key :id
      foreign_key :address_id, :addresses
      column :place_type, "varchar(255)", :null=>false
    end
    
    create_table(:listings) do
      foreign_key :id, :places
    end
    
    create_table(:schools) do
      foreign_key :id, :places
      column :rating, "integer"
      column :gsid, "varchar(255)"
      column :integer, "varchar(255)"
      column :parent_rating, "integer"
    end
  end
end
              Sequel.migration do
                change do
                  self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20160305000106_create_addresses.rb')"
self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20160305001122_create_places.rb')"
self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20160305005045_create_listings.rb')"
self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20160305005430_create_schools.rb')"
self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20160305011514_create_filters.rb')"
self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20160305014614_devise_create_users.rb')"
                end
              end

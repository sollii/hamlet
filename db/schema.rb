Sequel.migration do
  change do
    create_table(:addresses) do
      primary_key :id
      column :lat, "double precision"
      column :lon, "double precision"
      column :street, "varchar(255)"
      column :city, "varchar(255)"
      column :state, "varchar(255)"
      column :zip, "integer"
    end
    
    create_table(:city_parks_filters) do
      primary_key :id
      column :park_names, "varchar(255)", :default=>""
      column :distance_to_park, "varchar(255)", :default=>"99999"
    end
    
    create_table(:home_characteristics_filters) do
      primary_key :id
      column :bedrooms, "varchar(255)", :default=>""
      column :bathrooms, "varchar(255)", :default=>""
      column :sq_footage, "varchar(255)", :default=>"0"
    end
    
    create_table(:parks) do
      primary_key :id
      column :name, "varchar(255)"
      column :address, "varchar(255)"
      column :park_area, "double precision"
      column :lat, "double precision"
      column :lon, "double precision"
    end
    
    create_table(:schema_migrations) do
      column :filename, "varchar(255)", :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:school_filters) do
      primary_key :id
      column :desired_schools, "varchar(255)", :default=>""
      column :rating, "integer", :default=>Sequel::LiteralString.new("'8'")
    end
    
    create_table(:test_filters) do
      primary_key :id
      column :param_1, "varchar(255)"
      column :param_2, "varchar(255)"
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
      column :name, "varchar(255)"
      
      index [:email], :unique=>true
      index [:reset_password_token], :unique=>true
    end
    
    create_table(:area_filters) do
      primary_key :id
      column :name, "varchar(255)"
      foreign_key :address_id, :addresses
    end
    
    create_table(:distance_to_work_filters) do
      primary_key :id
      foreign_key :address_id, :addresses
      column :distance_to_work, "integer", :default=>Sequel::LiteralString.new("'999999999999'")
    end
    
    create_table(:filters) do
      primary_key :id
      column :filter_type, "varchar(255)", :null=>false
      column :precedence, "integer", :default=>Sequel::LiteralString.new("'0'")
      foreign_key :user_id, :users
    end
    
    create_table(:places) do
      primary_key :id
      foreign_key :address_id, :addresses
      column :place_type, "varchar(255)", :null=>false
    end
    
    create_table(:listings) do
      foreign_key :id, :places
      column :created_at, "timestamp"
      column :updated_at, "timestamp"
      column :bedrooms, "double precision", :default=>0.0
      column :bathrooms, "double precision", :default=>0.0
      column :sq_footage, "integer", :default=>0
      column :year, "integer", :default=>0
      column :price, "integer", :default=>0
    end
    
    create_table(:schools) do
      foreign_key :id, :places
      column :name, "varchar(255)"
      column :school_type, "varchar(255)"
      column :gs_rating, "integer"
      column :parent_rating, "integer"
      column :grade_range, "varchar(255)"
      column :enrollment, "integer"
      column :website, "varchar(255)"
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
self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20160305023025_create_test_filters.rb')"
self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20160305030926_add_columns_to_listing.rb')"
self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20160305052643_create_home_characteristics_filters.rb')"
self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20160308022603_create_distance_to_work_filters.rb')"
self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20160308023038_create_school_district_filters.rb')"
self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20160311014435_create_parks.rb')"
self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20160314230344_create_city_parks_filters.rb')"
self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20160321192315_add_name_to_user.rb')"
self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20160321200222_create_area_filters.rb')"
self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20160409091533_add_user_to_filter.rb')"
                end
              end

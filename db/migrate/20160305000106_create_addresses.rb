Sequel.migration do
  change do

    create_table :addresses do
      primary_key :id
      Float :lat
      Float :lng
      String :street
      String :city
      String :state
      Integer :zip
    end

  end
end
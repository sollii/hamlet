Sequel.migration do
  change do

    create_table :school_filters do
      primary_key :id
      String :desired_schools
      String :rating
    end

  end
end

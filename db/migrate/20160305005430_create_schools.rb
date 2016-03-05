Sequel.migration do
  change do

    create_table :schools do
      foreign_key :id, :places
      String :name
      String :school_type
      String :gs_rating
      String :parent_rating
      String :grade_range
      String :enrollment
      String :website
    end

  end
end

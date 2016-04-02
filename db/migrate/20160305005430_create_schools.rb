Sequel.migration do
  change do

    create_table :schools do
      foreign_key :id, :places
      String :name
      String :school_type
      Integer :gs_rating
      Integer :parent_rating
      String :grade_range
      Integer :enrollment
      String :website
    end

  end
end

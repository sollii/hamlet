Sequel.migration do
  change do

    create_table :schools do
      foreign_key :id, :places
      Integer :rating
      String :gsid
      String :integer
      Integer :parent_rating
    end

  end
end

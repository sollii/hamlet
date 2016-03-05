Sequel.migration do
  change do

    create_table :schools do
      foreign_key :id, :places
      Integer :rating
      String :gsid
      Integer :parent_rating
    end

  end
end

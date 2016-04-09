Sequel.migration do
  change do

    create_table :distance_to_work_filters do
      primary_key :id
      foreign_key :address_id, :addresses
      Integer :distance_to_work
    end

  end
end

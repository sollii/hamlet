Sequel.migration do
  change do

    create_table :distance_to_work_filters do
      primary_key :id
      Integer :distance_to_work
    end

  end
end

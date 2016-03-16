Sequel.migration do
  change do

    create_table :listings do
      foreign_key :id, :places
      DateTime :created_at
      DateTime :updated_at
    end

  end
end

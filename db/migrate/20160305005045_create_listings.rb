Sequel.migration do
  change do

    create_table :listings do
      foreign_key :id, :places
    end

  end
end

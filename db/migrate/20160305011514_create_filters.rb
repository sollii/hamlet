Sequel.migration do
  change do

    create_table :filters do
      primary_key :id
      foreign_key :user_id, :users
      String :filter_type, null: false
      Integer :precedence
    end

  end
end

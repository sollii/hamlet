Sequel.migration do
  change do
    alter_table :filters do
      add_foreign_key :user_id, :users
    end
  end
end

Sequel.migration do
  change do

    create_table :filters do
      primary_key :id
      String :filter_type, null: false
      Integer :precedence, :default => "0"
    end

  end
end

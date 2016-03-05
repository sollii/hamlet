Sequel.migration do 
  change do

    create_table :test_filters do
      primary_key :id
      String :param_1
      String :param_2
    end

  end
end
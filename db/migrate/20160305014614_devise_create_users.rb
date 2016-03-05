Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
            ## Database authenticatable
      String :email,              :null => false, :default => ""
      String :encrypted_password, :null => false, :default => ""

      ## Recoverable
      String :reset_password_token
      String :reset_password_sent_at

      ## Rememberable
      DateTime :remember_created_at

      ## Trackable
      Integer  :sign_in_count, :default => 0, :null => false
      DateTime :current_sign_in_at
      DateTime :last_sign_in_at
      String   :current_sign_in_ip
      String   :last_sign_in_ip

      ## Confirmable
      # String   :confirmation_token
      # DateTime :confirmed_at
      # DateTime :confirmation_sent_at
      # String   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # Integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # String   :unlock_token # Only if unlock strategy is :email or :both
      # DateTime :locked_at


      

      DateTime :created_at
      DateTime :updated_at
    end

    alter_table(:users) do
      add_index :email,                :unique => true
      add_index :reset_password_token, :unique => true
      # add_index :confirmation_token,   :unique => true
      # add_index :unlock_token,         :unique => true
    end
  end
end

class CreatePtAccounts < ActiveRecord::Migration
  def change
    create_table :pt_accounts do |t|
      t.string :email
      t.string :password_digest
      t.string :api_token
      t.references :user

      t.timestamps
    end
    add_index :pt_accounts, :user_id
  end
end

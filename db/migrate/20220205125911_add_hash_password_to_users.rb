class AddHashPasswordToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :hash_password, :string
  end
end

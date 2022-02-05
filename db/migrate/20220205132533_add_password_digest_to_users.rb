class AddPasswordDigestToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_digest, :string
  end
end


# https://qiita.com/fujiab/items/b744fdcd2f8d3686d4ca
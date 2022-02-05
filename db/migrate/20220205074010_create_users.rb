class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end


# マイグレーションファイル　データベースに与える変更をここで定義

# rails db:migrate データベース反映
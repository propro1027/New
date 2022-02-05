class User < ApplicationRecord
  # Active Recordのコールバックメソッド(before_save)
  # 現在のメールアドレス（self.email）の値をdowncaseメソッドを使って小文字に変換
  before_save {self.email = email.downcase}


  validates :name, presence: true,length: {minimum: 3}
  
  # ruby:本アプリケーションでのメールアドレスの正規表現
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true,length: {maximum: 30},
  format: { with: VALID_EMAIL_REGEX },
  
  # DBに保存する前に一意かどうかを検証
  uniqueness: true
  # セキュアパスワードというパスワードとパスワード確認をユーザーに入力させ、その２つの値をハッシュ化したものをデータベースに保存するという方法で脆弱性を回避します。
  has_secure_password
  validates :password, presence: true,length: {minimum: 6}

end
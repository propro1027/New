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


  # remenber_digest絡み

  # 渡された文字列のハッシュ値を返します。
  def User.digest(string)
    cost = 
    if ActiveModel::SecurePassword.min_cost
      BCypt::Engine::MIN_COST
    else
      BCypt::Engine.cost
    end
    BCypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返します。
def User.new_token
  SecureRandom.urlsafe_base64
end

# 永続セッションのためにハッシュ化したトークンをDB上に保存するめっそど
def remenber
  # ハッシュ化されたトークン情報」を代入
  self.remenber_token = User.new_token


#   update_attributeメソッドでトークンダイジェストを更新
#   pdate_attributesと違い（よく見ると末尾にsがあるかないかの違いがあります）、
# 　こちらはバリデーションを素通りさせます。
# 　今回はユーザーのパスワードなどにアクセス出来ないため、
# 　このメソッドを用いてバリデーションを素通りさせる必要がありました。

# https://tech-camp.in/note/technology/999/
  update_attribute(:remenber_digest, User.digest(remenber_token))
end

# トークンがダイジェストと一致すればtrueを返します。
def authenticated?(remenber_token)
  BCrypt::Password.new(remenber_digest).is_password?(remenber_token)
end

def forget
  update_attribute(:remenber_digest, nil)
end

end
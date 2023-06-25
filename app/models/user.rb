class User < ApplicationRecord
  before_save { self.email = email.downcase } # 全てのアドレス文字を小文字にしてセーブしてくれる。
  
  validates :name,  presence: true, length: {maximum: 50 } # 名前のバリテーション
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # 正規表現によるメールアドレスのフォーマット
  validates :email, presence: true, length: {maximum: 100 },# メールのバリテーション
             format: { with: VALID_EMAIL_REGEX },
             uniqueness: true # メールアドレスの一意性
             
  has_secure_password # パスワードをハッシュ化し、安全性を高める。
  validates :password, presence: true, length: {minimum: 6 }
end

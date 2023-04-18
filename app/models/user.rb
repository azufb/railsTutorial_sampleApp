class User < ApplicationRecord
    # データベースに保存される直前にemailを小文字に変換する
    # before_save { self.email = email.downcase }
    before_save { email.downcase! }

    # validates(:name, presence: true)の書き方でもOK
    validates :name, presence: true, length: { maximum: 50 }
    # 有効なメールアドレスの正規表現(大文字で始まる名前は定数)
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

    # ハッシュ化したパスワードをデータベース内のpassword_digest属性に保存できる
    # passwordとpassword_confirmationが使えるようになり、存在と値が一致するかどうかのバリデーションも追加
    # authenticateメソッドが使えるようになる
    has_secure_password

    validates :password, presence: true, length: { minimum: 6 }
end

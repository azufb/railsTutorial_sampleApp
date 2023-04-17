class User < ApplicationRecord
    # validates(:name, presence: true)の書き方でもOK
    validates :name, presence: true, length: { maximum: 50 }
    # 有効なメールアドレスの正規表現(大文字で始まる名前は定数)
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
end

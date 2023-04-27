class User < ApplicationRecord
    # インスタンス変数remember_tokenに対する読み取りメソッドと書き込みメソッドの両方を定義
    attr_accessor :remember_token
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
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    # テスト用データ(fixture)向けのdigestメソッド
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # ランダムなトークンを返す
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # 永続セッションのためにユーザーをデータベースに記憶する
    def remember
        # selfを使わないとローカル変数が作られてしまう(今回はローカル変数は不要)
        self.remember_token = User.new_token
        # 記憶ダイジェストを更新
        update_attribute(:remember_digest, User.digest(remember_token))
        remember_digest
    end

    # セッションハイジャック防止のためにセッショントークンを返す
    # この記憶ダイジェストを再利用しているのは単に利便性のため
    def session_token
        remember_digest || remember
    end

    # 渡されたトークンがダイジェストと一致したらtrueを返す
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # ユーザーのログイン情報を破棄する
    def forget
        # 記憶ダイジェストをnilで更新
        update_attribute(:remember_digest, nil)
    end
end

class User < ApplicationRecord
    has_many :microposts, dependent: :destroy
    has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower
    # インスタンス変数remember_tokenに対する読み取りメソッドと書き込みメソッドの両方を定義
    attr_accessor :remember_token, :activation_token, :reset_token
    # データベースに保存される直前にemailを小文字に変換する
    # before_save :メソッド名とすることで、メソッドを探して実行してくれる（メソッド参照）
    before_save :downcase_email
    # before_createはオブジェクトが生成される直前
    before_create :create_activation_digest

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
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    # ユーザーのログイン情報を破棄する
    def forget
        # 記憶ダイジェストをnilで更新
        update_attribute(:remember_digest, nil)
    end

    # アカウントを有効にする
    def activate
        update_attribute(:activated, true)
        update_attribute(:activated_at, Time.zone.now)
    end

    # 有効化用のメールを送信する
    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end

    # パスワード再設定の属性を設定する
    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest,  User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end

    # パスワード再設定のメールを送信する
    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    # パスワード再設定の期限が切れている場合はtrueを返す
    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end

    # ユーザーのステータスフィードを返す
    def feed
        following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
        Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id).includes(:user, image_attachment: :blob)
    end

    # ユーザーをフォローする
    def follow(other_user)
        following << other_user unless self == other_user
    end

    # ユーザーをフォロー解除する
    def unfollow(other_user)
        following.delete(other_user)
    end

    # 現在のユーザーが他のユーザーをフォローしていればtrueを返す
    def following?(other_user)
        following.include?(other_user)
    end

    private

    # メールアドレスをすべて小文字にする
    def downcase_email
      self.email = email.downcase
    end

    # 有効化トークンとダイジェストを作成および代入する
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end

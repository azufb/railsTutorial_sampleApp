class UsersController < ApplicationController
  # before_action
  # 何かの処理が実行される前に特定のメソッドを実行させる
  # ここでは、logged_in_userメソッド
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]

  def index
    # ユーザを取得
    # paginateメソッドを使って、引数として受け取ったページ番号の一塊のデータを取り出す
    @users = User.paginate(page: params[:page])
  end

  # データベースからユーザを取り出す
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    # Userオブジェクトを作る
    @user = User.new
  end

  # ユーザ登録フォームがPOSTで送信されてきたら実行されるアクション
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      # セッション固定攻撃対策でセッションidをリセット
      # reset_session
      # ユーザ登録と一緒にログインも済ませる
      # log_in @user
      # 登録完了したことを示すメッセージを表示
      # flashという変数を使う
      # flash[:success] = "Welcome to the Sample App!"
      # ユーザーのプロフィールページにリダイレクト(user_url(@user))
      # redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url, status: :see_other
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow', status: :unprocessable_entity
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow', status: :unprocessable_entity
  end

  private
    # privateメソッドのインデントは1つ深くする
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # beforeフィルタ

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      # admin?で管理者かどうか確認。管理者でなければリダイレクト。
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end
end

class UsersController < ApplicationController
  # データベースからユーザを取り出す
  def show
    @user = User.find(params[:id])
  end

  def new
    # Userオブジェクトを作る
    @user = User.new
  end

  # ユーザ登録フォームがPOSTで送信されてきたら実行されるアクション
  def create
    @user = User.new(user_params)
    if @user.save
      # セッション固定攻撃対策でセッションidをリセット
      reset_session
      # ユーザ登録と一緒にログインも済ませる
      log_in @user
      # 登録完了したことを示すメッセージを表示
      # flashという変数を使う
      flash[:success] = "Welcome to the Sample App!"
      # ユーザーのプロフィールページにリダイレクト(user_url(@user))
      redirect_to @user
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
      # 更新に成功した場合を扱う
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private
    # privateメソッドのインデントは1つ深くする
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end

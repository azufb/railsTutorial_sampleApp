class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      # セッション固定攻撃に対応するため、ログイン直前にセッションをリセットする
      # 新しいセッションidが使われるようになる
      reset_session
      # sessions_helperで定義したlog_in関数でログイン
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    # :see_otherでルートURLにリダイレクト
    redirect_to root_url, status: :see_other
  end
end

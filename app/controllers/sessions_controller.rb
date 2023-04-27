class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]
      # セッション固定攻撃に対応するため、ログイン直前にセッションをリセットする
      # 新しいセッションidが使われるようになる
      reset_session
      # フォームで送られてきたremember_meの値によって、処理分岐
      # 値が1であれば(チェックが入っていれば)、記憶する
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # sessions_helperで定義したlog_in関数でログイン
      log_in user
      redirect_to forwarding_url || user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    # logged_inがtrueの場合はlog_out
    log_out if logged_in?
    # :see_otherでルートURLにリダイレクト
    redirect_to root_url, status: :see_other
  end
end

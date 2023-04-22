module SessionsHelper
    # 渡されたユーザーでログインする
    def log_in(user)
        # Sessionsコントローラとは別物で、Railsで定義されているもの
        # ユーザIDを暗号化
        # ブラウザを閉じた瞬間に、有効期限が切れてしまう
        session[:user_id] = user.id
    end

    def current_user
        # 現在ログイン中のユーザがいる場合、ログイン中のユーザを返す
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    # ログイン状態をチェックする
    def logged_in?
        # sessionにユーザidが存在している、current_user関数の結果がnilではないこと
        !current_user.nil?
    end
end

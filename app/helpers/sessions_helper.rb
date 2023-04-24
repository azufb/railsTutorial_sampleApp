module SessionsHelper
    # 渡されたユーザーでログインする
    def log_in(user)
        # Sessionsコントローラとは別物で、Railsで定義されているもの
        # ユーザIDを暗号化
        # ブラウザを閉じた瞬間に、有効期限が切れてしまう
        session[:user_id] = user.id
    end

    # 永続セッションのためにユーザーをデータベースに記憶する
    def remember(user)
        user.remember
        cookies.permanent.encrypted[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    def current_user
        # 現在ログイン中のユーザがいる場合、ログイン中のユーザを返す
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.encrypted[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    # ログイン状態をチェックする
    def logged_in?
        # sessionにユーザidが存在している、current_user関数の結果がnilではないこと
        !current_user.nil?
    end

    # 永続的セッションを破棄
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    def log_out
        forget(current_user)
        reset_session
        @current_user = nil
    end
end

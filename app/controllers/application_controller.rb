class ApplicationController < ActionController::Base
  # どのコントローラからもログイン関連のメソッドを呼び出せるようにする
  include SessionsHelper

  private

    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
    end
end

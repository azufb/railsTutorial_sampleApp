class ApplicationController < ActionController::Base
  # どのコントローラからもログイン関連のメソッドを呼び出せるようにする
  include SessionsHelper
end

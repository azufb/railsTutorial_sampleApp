class UsersController < ApplicationController
  # データベースからユーザを取り出す
  def show
    @user = User.find(params[:id])
  end

  def new
    # Userオブジェクトを作る
    @user = User.new
  end
end

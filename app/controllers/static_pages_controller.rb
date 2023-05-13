# generateスクリプト実行時に、StaticPagesのようにキャメルケースで渡すことで、
# コントローラ名がスネークケースになったコントローラファイルが自動生成される。
# 単なる慣習であり、generateスクリプト実行時にスネークケースで渡しても問題はない。
# rails generateは関連するファイルを自動生成するコマンド
class StaticPagesController < ApplicationController
  # Rubyでは、メソッド(アクション)の中身が空であれば、何も実行しないが、
  # Railsの場合は、ApplicationControllerを継承しており、対応するビューが表示される。
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end

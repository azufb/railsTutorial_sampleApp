# generateスクリプト実行時に、StaticPagesのようにキャメルケースで渡すことで、
# コントローラ名がスネークケースになったコントローラファイルが自動生成される。
# 単なる慣習であり、generateスクリプト実行時にスネークケースで渡しても問題はない。
# rails generateは関連するファイルを自動生成するコマンド
class StaticPagesController < ApplicationController
  # Rubyでは、メソッド(アクション)の中身が空であれば、何も実行しないが、
  # Railsの場合は、ApplicationControllerを継承しており、対応するビューが表示される。
  def home
  end

  def help
  end
end

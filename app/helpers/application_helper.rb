# 組み込みの関数だけでなく自作の関数(メソッド)を使うこともできる。
# 自作の関数(メソッド)をカスタムヘルパーという。
module ApplicationHelper

    # ページごとの完全なタイトルを返す
    def full_title(page_title = '')
        # 変数base_titleへ代入
        base_title = "Ruby on Rails Tutorial Sample App"

        if page_title.empty?
            # page_titleが空であれば、base_titleを返す
            base_title
        else
            "#{page_title} | #{base_title}"
        end
    end
end

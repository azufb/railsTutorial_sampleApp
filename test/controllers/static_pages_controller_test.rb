require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  # setupメソッドは、各テストが実行される直前で実行される
  # 何度も繰り返し使われる文字列(ここでは、「Ruby on Rails Tutorial Sample App」)をインスタンス変数base_titleに格納
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  # GETリクエストをhomeアクションに対して送信
  # assertionで確認(ここでは、レスポンスが200/successになる)
  test "should get home" do
    get static_pages_home_url
    assert_response :success
    # assert_selectで特定のHTMLタグが存在するかをテスト
    # ここでは、<title>Home | Ruby on Rails Tutorial Sample App</title>が存在するかテスト
    assert_select "title", "Home | #{@base_title}"
  end

  # GETリクエストをhelpアクションに対して送信
  # assertionで確認(ここでは、レスポンスが200/successになる)
  test "should get help" do
    get static_pages_help_url
    assert_response :success
    # assert_selectで特定のHTMLタグが存在するかをテスト
    # ここでは、<title>Help | Ruby on Rails Tutorial Sample App</title>が存在するかテスト
    assert_select "title", "Help | #{@base_title}"
  end

  # GETリクエストをaboutアクションに対して送信
  # assertionで確認(ここでは、レスポンスが200/successになる)
  test "should get about" do
    get static_pages_about_url
    assert_response :success
    # assert_selectで特定のHTMLタグが存在するかをテスト
    # ここでは、<title>About | Ruby on Rails Tutorial Sample App</title>が存在するかテスト
    assert_select "title", "About | #{@base_title}"
  end
end

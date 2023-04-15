require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  # setupメソッドは、各テストが実行される直前で実行される
  # 何度も繰り返し使われる文字列(ここでは、「Ruby on Rails Tutorial Sample App」)をインスタンス変数base_titleに格納
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  # rootルーティングのテスト
  test "should get root" do
    get root_url
    assert_response :success
  end

  # GETリクエストをhomeアクションに対して送信
  # assertionで確認(ここでは、レスポンスが200/successになる)
  test "should get home" do
    get root_path
    assert_response :success
    # assert_selectで特定のHTMLタグが存在するかをテスト
    # ここでは、<title>Home | Ruby on Rails Tutorial Sample App</title>が存在するかテスト
    assert_select "title", @base_title
  end

  # GETリクエストをhelpアクションに対して送信
  # assertionで確認(ここでは、レスポンスが200/successになる)
  test "should get help" do
    get help_path
    assert_response :success
    # assert_selectで特定のHTMLタグが存在するかをテスト
    # ここでは、<title>Help | Ruby on Rails Tutorial Sample App</title>が存在するかテスト
    assert_select "title", "Help | #{@base_title}"
  end

  # GETリクエストをaboutアクションに対して送信
  # assertionで確認(ここでは、レスポンスが200/successになる)
  test "should get about" do
    get about_path
    assert_response :success
    # assert_selectで特定のHTMLタグが存在するかをテスト
    # ここでは、<title>About | Ruby on Rails Tutorial Sample App</title>が存在するかテスト
    assert_select "title", "About | #{@base_title}"
  end

  # GETリクエストをcontactアクションに対して送信
  # assertionで確認(ここでは、レスポンスが200/successになる)
  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end
end

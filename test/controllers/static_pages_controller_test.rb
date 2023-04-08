require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  # GETリクエストをhomeアクションに対して送信
  # assertionで確認(ここでは、レスポンスが200/successになる)
  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end

  # GETリクエストをhelpアクションに対して送信
  # assertionで確認(ここでは、レスポンスが200/successになる)
  test "should get help" do
    get static_pages_help_url
    assert_response :success
  end

  # GETリクエストをaboutアクションに対して送信
  # assertionで確認(ここでは、レスポンスが200/successになる)
  test "should get about" do
    get static_pages_about_url
    assert_response :success
  end
end

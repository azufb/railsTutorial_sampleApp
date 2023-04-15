require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    # 特定のリンクが存在するか確認する
    # countで個数まで指定してチェックできる
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path

    # サインアップページにアクセスして確認
    get signup_path
    assert_select "title", full_title("Sign up")
  end
end

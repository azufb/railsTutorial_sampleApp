require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  # 有効なユーザかテストする
  test "should be valid" do
    assert @user.valid?
  end

  # name属性の存在をテスト
  test "name should be present" do
    @user.name = " "
    # falseになったらOK
    assert_not @user.valid?
  end

  # email属性の存在をテスト
  test "email should be present" do
    @user.email = " "
    # falseになったらOK
    assert_not @user.valid?
  end

  # name属性の長さをテスト(max: 50)
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  # email属性の長さをテスト(max: 255)
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  # メールアドレスの有効性のテスト
  test "email validation should accept valid addresses" do
    # 有効なアドレスの配列(%w記法で、文字列の配列を作っている)
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  # メールアドレスの無効性のテスト
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
end

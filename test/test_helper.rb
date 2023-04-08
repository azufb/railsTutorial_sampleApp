ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
# minitest reportersは、テスト結果を見やすく出力するgem
# 色で成功/失敗を表現したり、パーセンテージなど出力してくれる
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

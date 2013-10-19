require 'test_helper'

class InstagramApiTest < ActionDispatch::IntegrationTest

  test "get tags" do
    response = Instagram.tag_recent_media('kebab')
    assert_not_nil response
  end
end
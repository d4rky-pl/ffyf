require 'test_helper'

class InstagramApiTest < ActionDispatch::IntegrationTest

  test "get tags" do
    assert_nothing_raised do
      response = Instagram.tag_recent_media('kebab')
    end
    assert_not_nil response
  end
end
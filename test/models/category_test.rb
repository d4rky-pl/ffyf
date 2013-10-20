require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "reverse hash" do
    Category.destroy_all
    Category.create!(:name => 'fine', :tags => 'one,two,three')
    Category.create!(:name => 'uncool', :tags => 'pretty_bad')
    Category.create!(:name => 'meh', :tags => 'whatever,whocares')

    hash = Category.reverse_hash
    assert_equal 6, hash.keys.length
    assert_equal 'fine', hash['one']
    assert_equal 3, hash.values.uniq.length
  end
end

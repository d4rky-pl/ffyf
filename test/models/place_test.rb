require 'test_helper'

class PlaceTest < ActiveSupport::TestCase
  test "address fetching" do
    p = Place.create(:name => "testing", :lat => 44.981667, :long => -93.27833, :id_instagram => 666)
    p.save!
    sleep(5)
    assert_equal "353 North 5th Street, Minneapolis, MN 55403, USA", p.address
  end
end

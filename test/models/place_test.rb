require 'test_helper'

class PlaceTest < ActiveSupport::TestCase

  test "address fetching" do
    p = Place.create(:name => "testing", :lat => 44.981667, :long => -93.27833, :id_instagram => 666)
    p.save!
    sleep(5)
    assert_equal "353 North 5th Street, Minneapolis, MN 55403, USA", p.address
  end

  test "close places" do
    kebab = Place.create!(
        name: "Ahmed Kebab",
        lat: 23.000000,
        long: 40.000000,
        id_instagram: 1
    )

    pizza = Place.create!(
        name: "Giovanni Pizza",
        lat: 23.010000,
        long: 41.990000,
        id_instagram: 2
    )

    close_places = Place.close_to(23.000000, 42.000000).load

    assert_equal 1, close_places.size
    assert_equal pizza, close_places.first
  end
end

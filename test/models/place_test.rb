require 'test_helper'

class PlaceTest < ActiveSupport::TestCase
  test "address fetching" do
    p = Place.create(:name => "testing", :lat => 44.981667, :long => -93.27833, :id_instagram => 666)
    p.save!
    sleep(5)
    puts p.address
    assert p.address
  end
end

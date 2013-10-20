class Place < ActiveRecord::Base
  has_many :photos
  validates :id_instagram, uniqueness: true

  acts_as_gmappable :lat => 'lat', :lng => 'long', :process_geocoding => false
end

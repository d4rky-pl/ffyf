class Place < ActiveRecord::Base
  has_many :photos

  validates :id_instagram, uniqueness: true, presence: true

  scope :close_to, -> (latitude, longitude, radius = 5000) {
    where(%{
      ST_DWithin(
        ST_GeographyFromText(
          'SRID=4326;POINT(' || places.long || ' ' || places.lat || ')'
        ),
        ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
        %d
      )
    } % [longitude, latitude, radius])
  }

  validates :id_instagram, uniqueness: true

  acts_as_gmappable :lat => 'lat', :lng => 'long', :process_geocoding => false
end

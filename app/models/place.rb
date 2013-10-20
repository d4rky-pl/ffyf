class Place < ActiveRecord::Base
  has_many :photos

  validates :id_instagram, uniqueness: true, presence: true

  scope :close_to, -> (latitude, longitude, radius = 50000) {
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

  scope :closest_to, -> (latitude, longitude, number = 15) {
    order(%{
      ST_Distance(
        ST_GeographyFromText(
           'SRID=4326;POINT(' || places.long || ' ' || places.lat || ')'
         ),
         ST_GeographyFromText('SRID=4326;POINT(%f %f)')
      )
    } % [longitude, latitude]).limit(number).close_to(latitude, longitude)
  }

  validates :id_instagram, uniqueness: true

  acts_as_gmappable :lat => 'lat', :lng => 'long', :process_geocoding => false
end

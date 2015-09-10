class Place < ActiveRecord::Base
  has_many :photos
  has_one :latest_photo, -> { order(created_at: :desc) }, class_name: 'Photo'

  validates :id_instagram, uniqueness: true, presence: true

  default_scope -> { order(created_at: :desc) }

  scope :close_to, lambda { |latitude, longitude, radius = 50000|
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

  scope :closest_to, lambda { |latitude, longitude, number = 15|
    order(%{
      ST_Distance(
        ST_GeographyFromText(
           'SRID=4326;POINT(' || places.long || ' ' || places.lat || ')'
         ),
         ST_GeographyFromText('SRID=4326;POINT(%f %f)')
      )
    } % [longitude, latitude]).limit(number).close_to(latitude, longitude)
  }

  acts_as_gmappable :lat => 'lat', :lng => 'long', :process_geocoding => false

  after_save :fetch_address

  def fetch_address
    adr = Geocoder.search("#{self.lat},#{self.long}").try(:first).try(:formatted_address)
    self.address = adr
  end

  def thumbnail
    latest_photo.try(:lowres_url) if latest_photo.present?
  end
end

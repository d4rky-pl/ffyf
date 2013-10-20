class Place < ActiveRecord::Base
  has_many :photos
  validates :id_instagram, uniqueness: true

  acts_as_gmappable :lat => 'lat', :lng => 'long', :process_geocoding => false

  after_save :fetch_address

  def fetch_address
    adr = Geocoder.search("#{self.lat},#{self.long}").try(:first).try(:formatted_address)
    self.address = adr
  end
end

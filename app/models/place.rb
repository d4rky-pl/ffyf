class Place < ActiveRecord::Base
  has_many :photos
  validates :id_instagram, uniqueness: true
end

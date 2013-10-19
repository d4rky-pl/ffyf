class Photo < ActiveRecord::Base
  belongs_to :place

  validates :place, presence: true
end

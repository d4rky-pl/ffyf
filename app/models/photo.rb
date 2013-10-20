class Photo < ActiveRecord::Base
  belongs_to :place
  has_and_belongs_to_many :categories

  validates :place, presence: true
end

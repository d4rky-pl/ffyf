class Photo < ActiveRecord::Base
  belongs_to :place
  has_and_belong_to_many :categories

  validates :place, presence: true
end

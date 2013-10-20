class Category < ActiveRecord::Base
  has_and_belongs_to_many :photos

  def tag_list
    tags.split(',')
  end

  # reverses :category => :tag1, tag2 hash into
  # { :tag1 => :category, :tag2 => :category }
  def self.reverse_hash
    reverse_hash = {}
    all = Category.all
    all.each do |category|
      category.tag_list.each do |tag|
        reverse_hash[tag] = category.name
      end
    end
    reverse_hash
  end
end

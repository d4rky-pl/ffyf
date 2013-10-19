namespace :instagram do
  task :init => :environment do
    #do nothing
  end

  task :get_tags => :init do
    tags = categories = nil
    if ENV['TAGS']
      tags = ENV['TAGS'].split(',')
    elsif ENV['CATEGORIES']
      categories = ENV['CATEGORIES'].split(',')
    else
      categories = Category.all
    end

    unless tags
      tags = categories.map(&:tag_list).inject([], :+)
    end

    tags.each { |tag| get_tag(tag) }
  end

  def get_tag(tag)
    puts "Getting tag: #{tag}"
    results = InstagramFetcher.get_by_tag tag, :since => 1.hours.ago
    tags = Category.reverse_hash

    results.each do |photo|
      place = create_place(photo.location)
      if place
        begin
          record = Photo.create!(
              url: photo.link,
              img_url: photo.images.standard_resolution.url,
              username: photo.user.username,
              description: photo.caption.text,
              place: place
          )

          photo.tags.each do |tag|
            if tags[tag]
              record.categories << Category.find_by_name(tags[tag])
            end
          end
        rescue
          # photo might be redundant if with two supported tags
        end
      end
    end
  end

  def create_place(place)
    return nil unless place
    place_record = Place.where(id_instagram: place.id.to_i).first
    if place_record
      return place_record
    else
      unless place.name.blank? # we don't want those as they might be taken at home or something
        return Place.create!(
            id_instagram: place.id.to_i,
            name: place.name,
            lat: place.latitude,
            long: place.longitude
        )
      end
    end
    return nil
  end
end

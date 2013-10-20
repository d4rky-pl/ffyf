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

    last_photo = Photo.order('created_at DESC').first

    tags.each { |tag| get_tag(tag, :since => last_photo.try(:created_at)) }
  end

  def get_tag(tag, opts={})
    logger = File.open("#{Rails.root}/log/instagram_fetcher.log", "a")
    logger.puts Time.now
    logger.puts "Getting tag: #{tag}"
    log_data = {all_photos: 0, no_location: 0, location: 0}
    results = InstagramFetcher.get_by_tag tag, :since => opts[:since] || 1.month.ago
    tags = Category.reverse_hash

    results.each do |photo|
      log_data[:all_photos] += 1
      place = create_place(photo.location)
      if place
        log_data[:location] += 1
        #begin
        record = Photo.create!(
            url: photo.link,
            img_url: photo.images.standard_resolution.url,
            lowres_url: photo.images.low_resolution.url,
            thumbnail_url: photo.images.thumbnail.url,
            username: photo.user.username,
            description: photo.caption.try(:text),
            place: place,
            created_at: DateTime.strptime(photo.created_time, '%s')
        )

        photo.tags.each do |tag|
          if tags[tag]
            record.categories << Category.find_by_name(tags[tag])
          end
        end
        #rescue
        # photo might be redundant if with two supported tags
        #end
      else
        log_data[:no_location] += 1
      end
    end

    logger.print "All: #{log_data[:all_photos]} | "
    logger.print "With location: #{log_data[:location]} | "
    logger.puts "No location: #{log_data[:no_location]}"
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

class InstagramFetcher
  def self.get_by_tag(tag, opts={})
    load_since = opts[:since].try(:to_i)
    max_id = nil
    images = []
    while load_since
      results = Instagram.tag_recent_media(tag, :max_id => max_id)
      results.each do |image|
        if image.type == 'image' && image.location
          #puts "#{image.tags} #{image.created_time}"
          images << image

          if image.created_time.to_i < load_since
            load_since = nil
            break
          end
        end
      end
      max_id = results.pagination.next_max_tag_id
    end
    images
  end

  def self.get_by_foursquare_id(fid)
    response = Instagram.location_search(fid)
  end

  def self.get_foursquare_venues(lat, long)
    photos_added = 0
    venues = FoursquareFetcher.nearby_locations(lat, long)
    venues.each do |venue|
      response = InstagramFetcher.get_by_foursquare_id(venue['id'].to_i)
      response = response.first
      if response
        instagram_location_id = response['id'].to_i
        photos = Instagram.location_recent_media(instagram_location_id, :count => 25)
        photos.each |photo|
            photos_added += 1 if InstagramFetcher.create_photo!(photo)
        end
      end
    end
  end

  def self.create_photo!(photo)
    # todo: optimize it somehow
    tags = Category.reverse_hash

    place = create_place!(photo.location)
    if place && !Photo.find_by_url(photo.link) # check for duplicates
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

      return record
    end
    return nil
  end

  def self.create_place!(place)
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
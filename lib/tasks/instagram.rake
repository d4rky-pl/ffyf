namespace :instagram do
  task :init => :environment do
    #do nothing
  end

  task :get_tags => :init do
    results = InstagramFetcher.get_by_tag 'kebab', :since => 1.hours.ago

    results.each do |photo|
      place = create_place(photo.location)
      if place
        Photo.create!(
            url: photo.link,
            img_url: photo.images.standard_resolution.url,
            username: photo.user.username,
            description: photo.caption.text,
            place: place
        )
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

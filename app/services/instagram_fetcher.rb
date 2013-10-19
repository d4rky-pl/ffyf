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
end
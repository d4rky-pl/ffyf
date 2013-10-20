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

    results.each do |photo|
      photo = InstagramFetcher.create_photo!(photo)
      photo ? log_data[:location] += 1 : log_data[:no_location] += 1
      log_data[:all_photos] += 1
    end

    logger.print "With location: #{log_data[:location]} | "
    logger.print "No location: #{log_data[:no_location]} | "
    logger.puts "(all: #{log_data[:all_photos]})"
  end

end

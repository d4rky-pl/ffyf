namespace :instagram do
  task :init => :environment do
    #do nothing
  end

  task :get_tags => :init do
    results = InstagramFetcher.get_by_tag 'kebab', :since => 8.hours.ago
    puts results.join("\n")\
  end
end

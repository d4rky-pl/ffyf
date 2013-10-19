yaml = YAML.load(File.open("#{Rails.root}/config/instagram.yml"))

Instagram.configure do |config|
  config.client_id = yaml['instagram']['client_id']
  config.access_token = yaml['instagram']['access_token']
end
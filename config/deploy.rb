require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina/puma'
require 'mina_sidekiq/tasks'
require 'mina/whenever'

set :domain, 'arkham.higher.lv'
set :user, 'app'

set :deploy_to, '/home/app/ffyf'
set :repository, 'git@bitbucket.org:d4rky-pl/fuckyeahfastfood/groop.git'

set :branch, 'master'
set :term_mode, :system

set :keep_releases, 2
set :shared_paths, ['log', 'config/database.yml', 'public/uploads']

set :sidekiq_pid, "#{deploy_to}/#{shared_path}/tmp/pids/sidekiq.pid"

task :environment do
  invoke :'rbenv:load'
end

task setup: :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/pids"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/sockets"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/sockets"]
end

desc "Deploys the current version to the server."
task deploy: :environment do
  deploy do
    invoke :'sidekiq:quiet'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    invoke :'whenever:clear'
    invoke :'whenever:update'
    to :launch do
      invoke :'sidekiq:restart'
      invoke :'puma:restart'
    end
  end
end

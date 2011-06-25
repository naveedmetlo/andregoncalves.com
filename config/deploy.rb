set :application,       'home'
set :repository,        'site/_site'
set :scm,               :none
set :deploy_via,        :copy
set :copy_compression,  :gzip
#set :use_sudo,          true
set :host,              'andregoncalves.com'

ssh_options[:port] = 8761

role :web,  host
role :app,  host
role :db,   host, :primary => true

set :user,    'andregoncalves'
set :group,   user

#set(:dest) { Capistrano::CLI.ui.ask("Destination: ") }

#if dest == 'dev'
#  set :deploy_to,    "/home/#{user}/sites/dev.#{application}.com"
#elsif dest == 'www'
#  set :deploy_to,    "/home/#{user}/sites/#{application}.com"
#end

set :deploy_to,    "/var/sites/#{application}"

before 'deploy:update', 'deploy:jekyll'

namespace :deploy do
  [:start, :stop, :restart, :finalize_update].each do |t|
    desc "#{t} task is a no-op with jekyll"
    task t, :roles => :app do ; end
  end

  desc 'Run jekyll to update site before uploading'
  task :jekyll do
    #%x(rm -rf _site/* && jekyll)
  end
end
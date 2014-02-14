#############################################################
#	Application
#############################################################
set :application,       'home'
set :host,              'andregoncalves.com'


ssh_options[:port] = 8761
default_run_options[:pty] = true

#############################################################
#	Source Control Settings
#############################################################
set :repository,        'site/_site'
set :scm,               :none
set :deploy_via,        :copy
set :copy_compression,  :gzip
#set :use_sudo,          true

#############################################################
#	Roles
#############################################################
role :web,  host
role :app,  host
role :db,   host, :primary => true


#############################################################
#	Ownership
#############################################################
set :user,    'andregoncalves'
set :group,   user


set :deploy_to,    "/var/sites/#{application}"

before 'deploy:update', 'deploy:jekyll'
after 'deploy:update', 'deploy:change_ownership'

namespace :deploy do
  [:start, :stop, :restart, :finalize_update].each do |t|
    desc "#{t} task is a no-op with jekyll"
    task t, :roles => :app do ; end
  end

  desc 'Run jekyll to update site before uploading'
  task :jekyll do
    #%x(rm -rf _site/* && jekyll)
  end

  desc 'Change ownership'
  task :change_ownership do
    sudo "chown -R www-data:www-data #{release_path}"
  end
end
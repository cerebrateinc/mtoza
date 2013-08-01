set :application, "mtoza"
set :repository,  "git@github.com:cerebrateinc/mtoza.git"
set :scm, :git

set :scm_user, "shon"  # The server's user for deploys
set :scm_passphrase, "macintosh"  # The deploy user's password
set :user, 'root'
set :use_sudo, false
set :normalize_asset_timestamps, false

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server "ec2-54-214-147-245.us-west-2.compute.amazonaws.com", :app, :web, :db, :primary => true
# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :change_ownership do
  	run "chown -R apache.apache /u/apps/*"
  end

end

after 'deploy:update_code', 'deploy:migrate'
after 'deploy:update_code', 'deploy:change_ownership'
set :keep_releases, 5
after "deploy:restart", "deploy:cleanup" 

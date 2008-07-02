default_run_options[:pty] = true 
set :application, "bakeryman2"
set :repository,  "git@github.com:rubygeek/bakeryman.git"
set :user, 'nola'

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/nola/#{application}"
set :scm, :git
set :deploy_via, 'copy'

role :app, "nickandnola.com"
role :web, "nickandnola.com"
role :db,  "nickandnola.com", :primary => true

after :deploy, :railsplayground_link


task :railsplayground_link do
  run "cd /home/nola/www; ln -s /home/nola/#{application}/current/public #{application}"
  run "chmod 755 /home/nola/#{application}/public/dispatch.cgi"
end

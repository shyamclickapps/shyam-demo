# The server-based syntax can be used to override options:
# ------------------------------------
set :branch, 'dev'
set :keep_releases, 3


server '202.164.34.20',
  user: 'clicksandbox',
  roles: %w{web app db},
ssh_options: {
  user: 'clicksandbox', # overrides user setting above
  keys: %w(~/.ssh/id_rsa),
  forward_agent: false,
  auth_methods: %w(publickey)
  # password: 'please use keys'
}

namespace :deploy do

  %w[start stop restart].each do |command|
    desc 'Manage Unicorn'
    task command do
      on roles(:app), in: :sequence, wait: 1 do
        execute "/etc/init.d/unicorn_shyam_dev #{command}"
      end
    end
  end

  after :publishing, :restart

end

# namespace :solr do
#
#   desc "Start solr instance for this application"
#   task :start do
#     system "cd #{current_path} && RAILS_ENV=dev ~/.rvm/bin/rvm 2.1.2@justnow do bin/bundle exec rake sunspot:solr:start"
#   end
#
#   desc "Stop solr instance for this application"
#   task :stop do
#     system "cd #{previous_release} && RAILS_ENV=dev ~/.rvm/bin/rvm 2.1.2@justnow do bin/bundle exec rake sunspot:solr:stop" rescue nil
#   end
#
#   desc "Restart solr instance for this application"
#   task :restart do
#     system "cd #{previous_release} && RAILS_ENV=dev ~/.rvm/bin/rvm 2.1.2@justnow do bin/bundle exec rake sunspot:solr:stop" rescue nil
#     system "cd #{current_path} && RAILS_ENV=dev ~/.rvm/bin/rvm 2.1.2@justnow do bin/bundle exec rake sunspot:solr:start"
#     system "cd #{current_path} && RAILS_ENV=dev ~/.rvm/bin/rvm 2.1.2@justnow do bin/bundle exec rake sunspot:solr:reindex"
#   end
#
#   after 'deploy:start',   'solr:start'
#   after 'deploy:stop',    'solr:stop'
#   after 'deploy:restart', 'solr:restart'
#
# end

# namespace :solr do
#   desc "start solr"
#   task :start, :roles => :app, :except => { :no_release => true } do
#     run "cd #{current_path} && RAILS_ENV=dev ~/.rvm/bin/rvm 2.1.2@justnow do bin/bundle exec rake sunspot:solr:start"
#   end
#
#   desc "stop solr"
#   task :stop, :roles => :app, :except => { :no_release => true } do
#     run "cd #{current_path} && RAILS_ENV=dev ~/.rvm/bin/rvm 2.1.2@justnow do bin/bundle exec rake sunspot:solr:stop"
#   end
#
#   desc "reindex the whole database"
#   task :reindex, :roles => :app do
#     stop
#     run "rm -rf #{shared_path}/solr/data/*"
#     start
#     puts "You need to run this yourself now:"
#     puts "cd #{current_path} && RAILS_ENV=dev ~/.rvm/bin/rvm 2.1.2@justnow do bin/bundle exec rake sunspot:solr:reindex"
#   end
#
#   desc "Symlink in-progress deployment to a shared Solr index"
#   task :symlink, :except => { :no_release => true } do
#     run "ln -s #{shared_path}/solr/data/ #{release_path}/solr/data"
#     run "ln -s #{shared_path}/solr/pids/ #{release_path}/solr/pids"
#   end
# end
#
# after "deploy:update_code", "solr:symlink"

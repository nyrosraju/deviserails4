# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'deviserails4'
set :repo_url, 'git@github.com:nyrosraju/deviserails4.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git

set :user, 'nyros'
set :deploy_to, "/home/nyros/veeru_workspace/Ror_projects/capistrano_app/deviserails4"

set :use_sudo, false

set :scm, :git

set :ssh_options, { :forward_agent => true }
# bundler
set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_dir, -> { shared_path.join('bundle') }
set :bundle_flags, '--deployment --quiet'
set :bundle_without, %w{development test}.join(' ')
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_roles, :all
#
#role :web, "10.90.90.194"                          # Your HTTP server, Apache/etc
#role :app, "10.90.90.194"                          # This may be the same as your `Web` server

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
set :deploy_via, :copy

set :stages, ["production"]
set :default_stage, "production"

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  desc 'Restart application'
  #
  #task :start do ; end
  #task :stop do ; end
  #
  before :deploy, "deploy:check_revision"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
    execute :mkdir, '-p', "#{release_path }/tmp"
    execute :touch, release_path.join('tmp/restart.txt')
      #execute 'sudo service nginx restart'
    end
  end

  after :publishing, :restart
  after :finishing, 'deploy:cleanup'
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

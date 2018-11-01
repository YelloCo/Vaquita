require 'config'
Config.load_and_set_settings(File.expand_path('../config/settings.local.yml', __dir__))

# config valid for current version and patch releases of Capistrano
lock '~> 3.11.0'

# config valid only for current version of Capistrano
set :application, 'Vaquita'
set :repo_url, Dir.pwd + '/.git'
set :rvm_custom_path, '/usr/share/rvm/'

set :deploy_to, '/var/www/vaquita/'
set :exclude_dir, 'tmp'
set :linked_dirs, %w[log tmp/sockets tmp/pids tmp/cache]
set :linked_files, fetch(:linked_files, []) + %w[config/settings.local.yml]

set :use_sudo, true
set :ssh_options, forward_agent: true
set :keep_releases, 3

set :puma_init_active_record, false
set :puma_preload_app, false

before 'deploy:check:linked_files', :copy_config
before 'bundler:install', 'deploy:symlink:linked_files'


# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }


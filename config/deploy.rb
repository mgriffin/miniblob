# config valid for current version and patch releases of Capistrano
lock "~> 3.19.2"

set :application, "miniblob"
set :repo_url, "git@github.com:mgriffin/miniblob.git"

# Default branch is :master
# ##ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, :main

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"
append :linked_dirs, ".bundle"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# set :ssh_options, {
#  keys: [File.join(ENV["HOME"], ".ssh", "id_rsa_miniblob")]
# }

set :rbenv_type, :user
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails]
set :rbenv_roles, :production

set :bundle_jobs, 1

set :puma_enable_socket_service, true
set :puma_service_unit_name, "puma_miniblob_mikegriffin_ie_production"
set :puma_systemctl_user, :system

append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "public/uploads"

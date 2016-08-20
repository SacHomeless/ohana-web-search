lock '3.5.0'

set :application, 'sacsos_web'
set :repo_url, 'https://github.com/SacHomeless/ohana-web-search.git'

if ENV["BRANCH"]
  set :branch, ENV["BRANCH"]
else
  ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
end

set :deploy_to, '/var/www/sacsos_web'

set :scm, :git

set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

append :linked_dirs, 'tmp/pids', 'tmp/sockets', 'log'
append :linked_files, 'config/application.yml', 'config/puma.rb'

set :keep_releases, 5

set :bundle_path, -> { shared_path.join('bundle') }

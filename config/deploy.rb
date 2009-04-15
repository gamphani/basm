set :domain, CLI.ui.ask("Domain you are deploying to (IP Address or Hostname): ")
set :local, "#{`ifconfig | grep "192"`.match(/192\.168\.\d+\.\d+/)}"
set :application, "BASM"
set :scm, :git
set :deploy_to, "/var/www/#{application}"
set :user, "deploy"
set :runner, "mongrel"
set :use_sudo, :false
set :distribution, local
set :repository, "git://#{distribution}/var/www/#{application}"


role :app, "#{domain}"
role :web, "#{domain}"
role :db,  "#{domain}", :primary => true

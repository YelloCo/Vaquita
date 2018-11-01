### Supported Systems

This application currently relies on bash commands to sync the git repositories that are only available in most Linux and OSX operating systems.

###  Prerequisites
1. The Settings file _(see Documentation)_ is configured.
2. Synced repositories are cloned on the system and the directory allows read/write permissions.
3. The system has Ruby 2.5.0 installed (chruby recommended).
4. The system has bundler installed (`gem install bundler --no-doc`).
5. The system has sqlite3 installed (`apt-get install sqlite3 libsqlite3-dev`). If you'd like to use a different DBMS, please refer to the default Rails DB configuration.

### Installation
Once the application source is on the server, run the following commands in order:

1. `bundle install`
2. `bundle exec rake db:setup`
3. `bundle exec rake user:create` and follow the on-screen prompts to create the initial user account.
4. `rails s` - this starts by default on port 3000. Use `-p 80` or put the app behind a reverse proxy to serve traffic on a different port.


### Ubuntu + Capistrano

1. Ubuntu 16.04
2. Install RVM
  2a. sudo apt-add-repository -y ppa:rael-gc/rvm
  2b. sudo apt-get update
  2c. source /etc/profile.d/rvm.sh
  2d. rvm install ruby-2.5.1
3. Install basic gems
  3a. gem install bundler --no-doc
4. Run `cap production deploy`


### Misc

1. Postfix is suggested to send email. Otherwise edit the source code to run through a relay instead.




### TODO

1. Add rake task for upgrading/installing. This should include:
b. Running db:migrate or db:setup
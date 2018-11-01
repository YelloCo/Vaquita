### Methods

Depending on how you installed the vaquita service, there are a couple of ways to upgrade the application.

### Manually

1. Fetch or checkout the latest code (`git checkout tag-number`)
2. Update the gems - `bundle install`
3. Update the database schema - `bundle exec rake db:migrate`
4. Restart the server - `rails restart` or `pumactl restart` depending on how you start the server

### Systemd

1. Using the provided systemd service file, simply call `sudo systemd restart vaquita`

_Note: The repository might upgrade the systemd file over time, so it is worth checking for changes and replacing the file as necessary_ 

### Capistrano

If you installed and deployed the applicaiton using Capistrano, running `cap production deploy` should take care of updating for you. You'll need to refresh the code locally (i.e. running from master: `git pull origin master`) before running capistrano.
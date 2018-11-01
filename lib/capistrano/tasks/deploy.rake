task :copy_config do
  on roles(:all) do
    raise 'Production settings file not found!' unless File.exist?('config/settings/production.yml')

    upload!('config/settings/production.yml', "#{shared_path}/config/settings.local.yml")
  end
end

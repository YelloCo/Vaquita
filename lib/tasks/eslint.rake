unless Rails.env.production?
  require 'eslintrb/eslinttask'

  Eslintrb::EslintTask.new :eslint do |t|
    t.pattern = 'app/**/*.js'
    t.options = :eslintrc
  end
end

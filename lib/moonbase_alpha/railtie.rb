require 'rails'

class MoonbaseAlpha::Railtie < Rails::Railtie
  railtie_name :moonbase_alpha

  rake_tasks do
    path = File.expand_path(__dir__)
    Dir.glob("#{path}/../tasks/**/*.rake").each { |f| load f }
  end
end
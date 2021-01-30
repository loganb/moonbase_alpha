
class MoonbaseGenerator < Rails::Generators::Base
  desc "Install basic moonbase files"
  def add_configuration
    create_file "config/moonbase_alpha.yml", <<-EOF
# This configuration is technically specified on a per-environment basis, but 
# moonbase doesn't currently use that
shared: 
  # Repository for the build. A build number will be set as the version
  repository: 
  # These packages will be available only while installing gems and precompiling assets
  build_packages: 
    - tzdata
    - postgresql-dev
    - sqlite-dev
  # These pckages will be available only at runtime in the final build image
  run_packages: 
    - postgresql-libs
    - tzdata
    - sqlite-libs
  # If true, moonbase will run `rake assets:precompile` (not suitable for API projects)
  compile_assets: false    
EOF

    environment do 
      "config.moonbase_alpha = config_for(:moonbase_alpha)"
    end

    create_file "app.rb", File.read(File.expand_path(__dir__ + "/../../../templates/app.rb"))
  end
end
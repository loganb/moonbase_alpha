require_relative 'config/boot'

require 'lamby'
require 'lamby/ssm_parameter_store'

#Loads any configuration given in ParameterStore (typically passwords)
path = "/config/#{ENV['RAILS_ENV']}/#{ENV['SERVICE_NAME']}/env"
$envs = Lamby::SsmParameterStore.new path
$envs.get!
$envs.to_env

require_relative 'config/application'
require_relative 'config/environment'

$app = Rack::Builder.new { run Rails.application }.to_app

def handler(event:, context:)
  
  if(event["source"] == 'aws.events')
    Rails.logger.info("Processing a cron event")
    ActiveRecord::Base.connection.query_cache.clear
    # Event coming from Cloudwatch Events
  else
    # Lamby's standard path
    Lamby.handler $app, event, context, rack: :api
  end
end
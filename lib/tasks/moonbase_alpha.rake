require 'digest'
require 'fileutils'

require 'rake/packagetask'

require 'moonbase_alpha/rake_helper'



namespace :moonbase_alpha do

  LambdaLayerCake::RakeHelper.new(Rails.root).tap do |rh| 
    rh.docker_build_definitions!
  end
  
end
require "moonbase_alpha/version"

require 'moonbase_alpha/railtie' if defined? ::Rails::Railtie

module MoonbaseAlpha
  class Error < StandardError; end
  # Your code goes here...
end

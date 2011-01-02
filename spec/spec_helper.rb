
# $:.unshift File.expand_path('..', __FILE__)
# $:.unshift File.expand_path('../../lib', __FILE__)

require 'rubygems'
require 'spec'
require 'spec/autorun'
require 'spec/matchers'
require 'evernicious'

# Uncomment the next line to use webrat's matchers
#require 'webrat/integrations/rspec-rails'

module Evernicious
  module Spec 
    class Initializer
      attr_accessor :config

      REQUIRED_PATHS = [
        "/support/**/*.rb",
        "../lib/**/*.rb"
      ]
      
      def initialize(config)
        @config = config
      end
      
      def configure 
        require_supporting_files
        init_rspec_config
      end
      
      def require_supporting_files
        REQUIRED_PATHS.each do |file_pattern|
          Dir[File.dirname(__FILE__) + file_pattern].each do |file|
            require file
          end
        end
      end
      
      def init_rspec_config
        config.include BookmarkHelpers
      end
      
    end
  end
end

Spec::Runner.configure do |config|
  Evernicious::Spec::Initializer.new(config).configure()
end


class Spec::Matchers::Matcher
  include BookmarkHelpers
end






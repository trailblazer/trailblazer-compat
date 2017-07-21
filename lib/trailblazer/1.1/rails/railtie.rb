begin
  require 'rails/railtie'
rescue LoadError
else

  module Trailblazer::V1_1
    class Railtie < ::Rails::Railtie
      module ExtendApplicationController
        def extend_application_controller!(app)
          # this requires trailblazer-rails-1.0.3
          application_controller = super

          v2_Controller = Trailblazer::Rails::Controller

          application_controller.class_eval do
            include v2_Controller # if Trailblazer::Operation.const_defined?(:Controller) # from V2.
            alias_method :run_v2, :run
            include Trailblazer::V1_1::Operation::Controller
          end
        end
      end


      # This is to autoload Operation::Dispatch, etc. I'm simply assuming people find this helpful in Rails.
      initializer "trailblazer.library_autoloading" do
        require "trailblazer/1.1/autoloading"
      end

      initializer "trailblazer.application_controller.compat", before: "trailblazer.application_controller" do |app|
        require "trailblazer/rails/railtie"

        if Gem::Version.new(Trailblazer::Rails::VERSION) < Gem::Version.new("1.0.4")
          raise "[Trailblazer-compat] Please update to trailblazer-rails 1.0.4 or above."
        end

        Trailblazer::Railtie.extend ExtendApplicationController
      end
    end # Railtie
  end
end

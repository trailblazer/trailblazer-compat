require "rails/railtie"

module Trailblazer::V1_1
  class Railtie < ::Rails::Railtie
    # This is to autoload Operation::Dispatch, etc. I'm simply assuming people find this helpful in Rails.
    initializer "trailblazer.library_autoloading" do
      require "trailblazer/1.1/autoloading"
    end

    initializer "trailblazer.application_controller" do
      ActiveSupport.on_load(:action_controller) do
        require "trailblazer/rails/railtie"
        # this requires trailblazer-rails-1.0.0
        V2_Controller = Trailblazer::Rails::Controller

        ActionController::Base.class_eval do
          include V2_Controller # if Trailblazer::Operation.const_defined?(:Controller) # from V2.
          alias run_v2 run
          include Trailblazer::V1_1::Operation::Controller
        end
      end
    end
  end
end

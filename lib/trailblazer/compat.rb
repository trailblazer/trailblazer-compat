require "trailblazer/compat/version"

module Trailblazer
  module V1_1
    # Your code goes here...
  end
end

require "trailblazer/1.1/rails"

Trailblazer::Operation = Trailblazer::V1_1::Operation
Trailblazer::NotAuthorizedError = Trailblazer::V1_1::NotAuthorizedError

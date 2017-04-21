require "trailblazer/compat/version"

module Trailblazer
  module V1_1
    # Your code goes here...
  end

  module V2
  end

  module Compat
    module Version
      def version(v)
        V2::Operation
      end
    end
  end
end


require "trailblazer/operation" # 2.x
require "trailblazer/operation/model" # 2.x
require "trailblazer/operation/policy" # 2.x
require "trailblazer/operation/pundit" # 2.x
require "trailblazer/operation/guard" # 2.x
require "trailblazer/operation/contract" # 2.x
require "trailblazer/operation/validate" # 2.x
require "trailblazer/operation/persist" # 2.x
require "trailblazer/operation/rescue" # 2.x
require "trailblazer/operation/wrap" # 2.x
require "trailblazer/operation/nested" # 2.x

Trailblazer::V2::Operation = ::Trailblazer::Operation # copy TRB2 Operation constant to a safe place.

require "trailblazer/1.1/rails"

Trailblazer.send(:remove_const, :Operation)
Trailblazer.send(:const_set, :Operation, Trailblazer::V1_1::Operation) # TRB::Op is now TRB 1.1

# Trailblazer::Operation = Trailblazer::V1_1::Operation
Trailblazer::NotAuthorizedError = Trailblazer::V1_1::NotAuthorizedError

Trailblazer::Operation.extend(Trailblazer::Compat::Version)

Trailblazer::V2::Operation::Nested.module_eval do
  def self.nestable_object?(object)
    # interestingly, with < we get a weird nil exception. bug in Ruby?
    object.is_a?(Class) && object <= Trailblazer::V2::Operation
  end
end

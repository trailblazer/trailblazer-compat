module Trailblazer::V1_1::Operation::Responder
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def model_name
      model_class.model_name
    end
  end

  extend Forwardable
  def_delegators :@model, :to_param, :destroyed?, :persisted?

  def to_model
    @model
  end
end

require "uber/builder"

# Allows to add builders via ::builds.
module Trailblazer::V1_1::Operation::Builder
  def self.extended(extender)
    extender.send(:include, Uber::Builder)
  end

  def builder_class
    @builders
  end

  def builder_class=(constant)
    @builders = constant
  end

private
  # Runs the builders for this operation class to figure out the actual class.
  def build_operation_class(*args)
    class_builder(self).(*args) # Uber::Builder::class_builder(context)
  end

  def build_operation(params, options={})
    build_operation_class(params).new(params, options)
  end
end

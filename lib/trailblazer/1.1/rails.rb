require "reform/rails"
require "trailblazer/1.1/rails/railtie"

require "trailblazer/1.1/operation"
# TODO: remove that once i18n, validations etc in Reform/AM are sorted.
Trailblazer::V1_1::Operation.contract_class.class_eval do
  def self.name
    # for whatever reason, validations climb up the inheritance tree and require _every_ class to have a name (4.1).
    "Reform::Form"
  end
end

# Automatically set model_name on operation's contract when `Op::Model` is included.
require "trailblazer/1.1/operation/model"
require "trailblazer/1.1/operation/model/active_model"
Trailblazer::V1_1::Operation::Model::DSL.module_eval do
  include Trailblazer::V1_1::Operation::Model::ActiveModel # ::contract.
end

require "trailblazer/1.1/autoloading"
require "trailblazer/1.1/rails/autoloading"


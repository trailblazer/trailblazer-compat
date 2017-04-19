Trailblazer::V1_1.class_eval do
  autoload :NotAuthorizedError, "trailblazer/1.1/operation/policy"
end

Trailblazer::V1_1::Operation.class_eval do
  autoload :Controller, "trailblazer/1.1/operation/controller"
  autoload :Model,      "trailblazer/1.1/operation/model"
  autoload :Collection, "trailblazer/1.1/operation/collection"
  autoload :Dispatch,   "trailblazer/1.1/operation/dispatch" # TODO: remove in 1.2.
  autoload :Callback,   "trailblazer/1.1/operation/callback"
  autoload :Module,     "trailblazer/1.1/operation/module"
  autoload :Representer,"trailblazer/1.1/operation/representer"
  autoload :Policy,     "trailblazer/1.1/operation/policy"
  autoload :Resolver,   "trailblazer/1.1/operation/resolver"
end

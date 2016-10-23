    module Deprecations # from 1.1.
      def contract_class=(constant)
        warn %{[Trailblazer] Operation::contract_class= is deprecated, please use Operation::["contract.class"]=}
        self["contract.class"] = constant
      end

      def contract_class
        warn %{[Trailblazer] Operation::contract_class is deprecated, please use Operation::["contract.class"]}
        self["contract.class"]
      end
    end

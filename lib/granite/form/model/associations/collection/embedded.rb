module Granite
  module Form
    module Model
      module Associations
        module Collection
          class Embedded < Proxy
            delegate :build, to: :@association
            delegate :delete, to: :target
            alias_method :new, :build
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module Granite
  module Form
    module Types
      class String < Object
        def typecast(value)
          value.to_s
        end
      end
    end
  end
end

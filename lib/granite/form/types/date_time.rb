# frozen_string_literal: true

module Granite
  module Form
    module Types
      class DateTime < Object
        def typecast(value)
          value.try(:to_datetime)
        rescue ArgumentError
          nil
        end
      end
    end
  end
end

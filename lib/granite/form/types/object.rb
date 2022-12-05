# frozen_string_literal: true

module Granite
  module Form
    module Types
      class Object
        attr_reader :reflection, :owner, :type
        delegate :name, to: :reflection

        def initialize(type, reflection, owner)
          @type = type
          @reflection = reflection
          @owner = owner
        end

        def ensure_type(value)
          if value.instance_of?(type)
            value
          elsif !value.nil?
            typecast(value)
          end
        end

        def typecast(value)
          value if value.is_a?(type)
        end
      end
    end
  end
end

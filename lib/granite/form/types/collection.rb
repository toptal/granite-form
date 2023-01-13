module Granite
  module Form
    module Types
      class Collection
        delegate :reflection, :owner, :type, :name, to: :subtype_definition
        attr_reader :subtype_definition

        def initialize(subtype_definition)
          @subtype_definition = subtype_definition
        end

        def prepare(value)
          if value.respond_to? :transform_values
            value.transform_values { |v| subtype_definition.prepare(v) }
          elsif value.respond_to?(:map)
            value.map { |v| subtype_definition.prepare(v) }
          end
        end
      end
    end
  end
end

module Granite
  module Form
    module Model
      module Attributes
        class Collection < Attribute
          def read
            @value ||= normalize(read_before_type_cast.map { |value| type_definition.prepare(value) })
          end

          def read_before_type_cast
            @value_before_type_cast ||= Array.wrap(@value_cache).map { |value| defaultize(value) }
          end
        end
      end
    end
  end
end

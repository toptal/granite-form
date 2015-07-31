module ActiveData
  module Model
    module Attributes
      class Attribute < Base
        delegate :typecaster, :defaultizer, :enumerizer, :normalizers, to: :reflection

        def read
          @value ||= normalize(enumerize(typecast(read_before_type_cast)))
        end

        def read_before_type_cast
          @value_before_type_cast ||= defaultize(@raw_value)
        end

        def write value
          @value = nil
          @value_before_type_cast = nil
          super
        end

        def default
          defaultizer.is_a?(Proc) ? evaluate(&defaultizer) : defaultizer
        end

        def defaultize value
          defaultizer && value.nil? ? default : value
        end

        def typecast value
          if value.instance_of?(type)
            value
          else
            typecaster.call(value, self) unless value.nil?
          end
        end

        def enum
          source = enumerizer.is_a?(Proc) ? evaluate(&enumerizer) : enumerizer

          case source
          when Range
            source.to_a
          when Set
            source
          else
            Array.wrap(source)
          end.to_set
        end

        def enumerize value
          set = enum if enumerizer
          value if !set || (set.none? || set.include?(value))
        end

        def normalize value
          if normalizers.none?
            value
          else
            normalizers.inject(value) do |value, normalizer|
              case normalizer
              when Proc
                evaluate(value, &normalizer)
              when Hash
                normalizer.inject(value) do |value, (name, options)|
                  ActiveData.normalizer(name).call(value, options, self)
                end
              else
                ActiveData.normalizer(normalizer).call(value, {}, self)
              end
            end
          end
        end
      end
    end
  end
end
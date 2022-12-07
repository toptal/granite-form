module Granite
  module Form
    module Model
      module Attributes
        module Reflections
          class Base
            attr_reader :name, :options

            class << self
              def build(_target, _generated_methods, name, *args, &block)
                options = args.extract_options!
                options[:type] = args.first if args.first
                options[:default] = block if block
                new(name, options)
              end

              def generate_methods(name, target) end

              def attribute_class
                @attribute_class ||= "Granite::Form::Model::Attributes::#{name.demodulize}".constantize
              end
            end

            def initialize(name, options = {})
              @name = name.to_s
              @options = options
            end

            def build_attribute(owner, raw_value = Granite::Form::UNDEFINED)
              attribute = self.class.attribute_class.new(self, owner)
              attribute.write_value(raw_value, origin: :persistence) unless raw_value == Granite::Form::UNDEFINED
              attribute
            end

            def type
              @type ||= case options[:type]
              when Class, Module
                options[:type]
              when nil
                raise "Type is not specified for `#{name}`"
              else
                options[:type].to_s.camelize.constantize
              end
            end

            def typecaster
              @typecaster ||= Granite::Form.typecaster(type.ancestors.grep(Class))
            end

            def readonly
              @readonly ||= options[:readonly]
            end

            def inspect_reflection
              "#{name}: #{type}"
            end
          end
        end
      end
    end
  end
end

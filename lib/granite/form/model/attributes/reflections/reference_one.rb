module Granite
  module Form
    module Model
      module Attributes
        module Reflections
          class ReferenceOne < Base
            def self.generate_methods(name, target)
              target.define_method(name) do
                attribute(name).read
              end

              target.define_method("#{name}=") do |value|
                attribute(name).write(value)
              end

              target.define_method("#{name}?") do
                attribute(name).query
              end

              target.define_method("#{name}_before_type_cast") do
                attribute(name).read_before_type_cast
              end
            end

            def inspect_reflection
              "#{name}: (reference)"
            end

            def association
              @association ||= options[:association].to_s
            end
          end
        end
      end
    end
  end
end

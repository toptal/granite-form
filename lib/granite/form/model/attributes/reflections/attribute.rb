module Granite
  module Form
    module Model
      module Attributes
        module Reflections
          class Attribute < Base
            def self.attribute_class
              Granite::Form::Model::Attributes::Attribute
            end

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

              target.define_method("#{name}_came_from_user?") do
                attribute(name).came_from_user?
              end

              target.define_method("#{name}_default") do
                attribute(name).default
              end

              target.define_method("#{name}_values") do
                attribute(name).enum.to_a
              end
            end

            def defaultizer
              @defaultizer ||= options[:default]
            end

            def normalizers
              @normalizers ||= Array.wrap(options[:normalize] || options[:normalizer] || options[:normalizers])
            end
          end
        end
      end
    end
  end
end

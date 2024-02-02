module Granite
  module Form
    module Model
      module Associations
        module Reflections
          class EmbedsOne < EmbedsAny
            include Singular

            def self.build(target, generated_methods, name, options = {}, &block)
              target.add_attribute(Granite::Form::Model::Attributes::Reflections::Base, name, type: Object) if target < Granite::Form::Model::Attributes
              options[:validate] = true unless options.key?(:validate)
              super
            end

            def self.generate_methods(name, target)
              super

              target.define_method("build_#{name}") do |attributes = {}|
                association(name.to_sym).build(attributes)
              end
            end
          end
        end
      end
    end
  end
end

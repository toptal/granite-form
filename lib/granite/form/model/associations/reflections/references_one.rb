require 'granite/form/model/attributes/reflections/reference_one'
require 'granite/form/model/attributes/reference_one'

module Granite
  module Form
    module Model
      module Associations
        module Reflections
          class ReferencesOne < ReferencesAny
            include Singular

            def self.build(target, generated_methods, name, *args, &block)
              reflection = super

              target.add_attribute(
                Granite::Form::Model::Attributes::Reflections::ReferenceOne,
                reflection.reference_key, association: name
              )

              reflection
            end

            def reference_key
              @reference_key ||= options[:reference_key].presence.try(:to_sym) ||
                :"#{name}_#{primary_key}"
            end
          end
        end
      end
    end
  end
end

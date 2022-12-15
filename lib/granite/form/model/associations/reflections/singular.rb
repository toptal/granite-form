module Granite
  module Form
    module Model
      module Associations
        module Reflections
          module Singular
            extend ActiveSupport::Concern

            module ClassMethods
              def generate_methods(name, target)
                super

                target.class_eval <<-RUBY, __FILE__, __LINE__ + 1
                def build_#{name} attributes = {}
                  association(:#{name}).build(attributes)
                end
                RUBY
              end
            end

            def collection?
              false
            end
          end
        end
      end
    end
  end
end

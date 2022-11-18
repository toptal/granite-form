require 'granite/form/model/attributes/reflections/localized'
require 'granite/form/model/attributes/localized'

module Granite
  module Form
    module Model
      module Localization
        extend ActiveSupport::Concern

        module ClassMethods
          def localized(*args, &block)
            add_attribute(Granite::Form::Model::Attributes::Reflections::Localized, *args, &block)
          end

          def fallbacks(locale)
            ::I18n.respond_to?(:fallbacks) ? ::I18n.fallbacks[locale] : [locale]
          end

          def locale
            I18n.locale
          end
        end
      end
    end
  end
end

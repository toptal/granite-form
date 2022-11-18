require 'tzinfo'
require 'active_support'
require 'active_support/deprecation'
require 'active_support/core_ext'
require 'active_support/concern'
require 'singleton'

require 'active_model'

require 'granite/form/version'
require 'granite/form/errors'
require 'granite/form/extensions'
require 'granite/form/undefined_class'
require 'granite/form/config'
require 'granite/form/railtie' if defined? Rails
require 'granite/form/model'
require 'granite/form/model/associations/persistence_adapters/base'
require 'granite/form/model/associations/persistence_adapters/active_record'

module Granite
  module Form
    BOOLEAN_MAPPING = {
      1 => true,
      0 => false,
      '1' => true,
      '0' => false,
      't' => true,
      'f' => false,
      'T' => true,
      'F' => false,
      true => true,
      false => false,
      'true' => true,
      'false' => false,
      'TRUE' => true,
      'FALSE' => false,
      'y' => true,
      'n' => false,
      'yes' => true,
      'no' => false
    }.freeze

    def self.config
      Granite::Form::Config.instance
    end

    singleton_class.delegate(*Granite::Form::Config.delegated, to: :config)

    typecaster('Object') { |value, attribute| value if value.class < attribute.type }
    typecaster('String') { |value, _| value.to_s }
    typecaster('Array') do |value|
      case value
      when ::Array then
        value
      when ::String then
        value.split(',').map(&:strip)
      end
    end
    typecaster('Hash') do |value|
      case value
      when ::Hash then
        value
      end
    end
    ActiveSupport.on_load :action_controller do
      Granite::Form.typecaster('Hash') do |value|
        case value
        when ActionController::Parameters
          value.to_h if value.permitted?
        when ::Hash then
          value
        end
      end
    end
    typecaster('Date') do |value|
      begin
        value.to_date
      rescue ArgumentError, NoMethodError
        nil
      end
    end
    typecaster('DateTime') do |value|
      begin
        value.to_datetime
      rescue ArgumentError
        nil
      end
    end
    typecaster('Time') do |value|
      begin
        value.is_a?(String) && ::Time.zone ? ::Time.zone.parse(value) : value.to_time
      rescue ArgumentError
        nil
      end
    end
    typecaster('ActiveSupport::TimeZone') do |value|
      case value
      when ActiveSupport::TimeZone
        value
      when ::TZInfo::Timezone
        ActiveSupport::TimeZone[value.name]
      when String, Numeric, ActiveSupport::Duration
        value = begin
                  Float(value)
                rescue ArgumentError, TypeError
                  value
                end
        ActiveSupport::TimeZone[value]
      end
    end
    typecaster('BigDecimal') do |value|
      next unless value
      begin
        BigDecimal(Float(value).to_s)
      rescue ArgumentError, TypeError
        nil
      end
    end
    typecaster('Float') do |value|
      begin
        Float(value)
      rescue ArgumentError, TypeError
        nil
      end
    end
    typecaster('Integer') do |value|
      begin
        Float(value).to_i
      rescue ArgumentError, TypeError
        nil
      end
    end
    typecaster('Boolean') { |value| BOOLEAN_MAPPING[value] }
    typecaster('Granite::Form::UUID') do |value|
      case value
      when UUIDTools::UUID
        Granite::Form::UUID.parse_raw value.raw
      when Granite::Form::UUID
        value
      when String
        Granite::Form::UUID.parse_string value
      when Integer
        Granite::Form::UUID.parse_int value
      end
    end
  end
end

require 'granite/form/base'

Granite::Form.base_class = Granite::Form::Base

ActiveSupport.on_load :active_record do
  require 'granite/form/active_record/associations'
  require 'granite/form/active_record/nested_attributes'

  include Granite::Form::ActiveRecord::Associations
  singleton_class.prepend Granite::Form::ActiveRecord::NestedAttributes

  def self.granite_persistence_adapter
    Granite::Form::Model::Associations::PersistenceAdapters::ActiveRecord
  end
end

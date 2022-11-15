require 'granite/form/model'
require 'granite/form/model/primary'
require 'granite/form/model/lifecycle'
require 'granite/form/model/associations'

module Granite
  module Form
    class Base
      include Granite::Form::Model
      include Granite::Form::Model::Primary
      include Granite::Form::Model::Lifecycle
      include Granite::Form::Model::Associations
    end
  end
end

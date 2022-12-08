require 'spec_helper'

describe Granite::Form::ActiveRecord::NestedAttributes do
  before do
    stub_class(:user, ActiveRecord::Base) do
      embeds_one :profile
      embeds_many :projects

      accepts_nested_attributes_for :profile, :projects
    end
  end

  include_examples 'nested attributes'
end

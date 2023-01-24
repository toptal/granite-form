require 'spec_helper'

RSpec.describe Granite::Form::Types::Collection do
  subject { described_class.new(subtype_definition) }
  let(:subtype_definition) { Granite::Form::Types::Object.new(Dummy, reflection, nil) }
  let(:reflection) { Granite::Form::Model::Attributes::Reflections::Base.new(:field) }
  let(:dummy_object) { Dummy.new }

  before { stub_class :dummy }

  describe '#prepare' do
    specify { expect(subject.prepare([dummy_object, Object.new])).to eq([dummy_object, nil]) }
    specify { expect(subject.prepare(one: dummy_object, two: Object.new)).to eq(one: dummy_object, two: nil) }
  end
end

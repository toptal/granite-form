require 'spec_helper'

describe Granite::Form::Model::Attributes::Reflections::Base do
  def reflection(options = {})
    described_class.new(:field, options)
  end

  describe '.build' do
    before { stub_class(:target) }

    specify do
      described_class.build(Class.new, Target, :field)
      expect(Target).not_to be_method_defined(:field)
    end
    specify { expect(described_class.build(Class.new, Target, :field).name).to eq('field') }
  end

  describe '.attribute_class' do
    before do
      stub_class('SomeScope::Borogoves', described_class)
      stub_class('Granite::Form::Model::Attributes::Borogoves')
    end

    specify { expect(described_class.attribute_class).to eq(Granite::Form::Model::Attributes::Base) }
    specify { expect(SomeScope::Borogoves.attribute_class).to eq(Granite::Form::Model::Attributes::Borogoves) }
  end

  describe '#name' do
    specify { expect(reflection.name).to eq('field') }
  end

  describe '#build_attribute' do
    subject { reflection.build_attribute(owner, nil) }

    before do
      stub_class('SomeScope::Borogoves', described_class)
      stub_class('Granite::Form::Model::Attributes::Borogoves', Granite::Form::Model::Attributes::Base)
      stub_class(:owner)
    end

    let(:reflection) { SomeScope::Borogoves.new(:field, type: Object) }
    let(:owner) { Owner.new }

    it { is_expected.to be_a(Granite::Form::Model::Attributes::Borogoves) }
    it { is_expected.to have_attributes(reflection: reflection, owner: owner, type: Object) }
  end
end

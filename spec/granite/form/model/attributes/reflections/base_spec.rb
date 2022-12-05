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
    before do
      stub_class('SomeScope::Borogoves', described_class)
      stub_class('Granite::Form::Model::Attributes::Borogoves', Granite::Form::Model::Attributes::Base)
      stub_class(:owner)
    end

    let(:reflection) { SomeScope::Borogoves.new(:field, type: Object) }
    let(:owner) { Owner.new }

    specify { expect(reflection.build_attribute(owner, nil)).to be_a(Granite::Form::Model::Attributes::Borogoves) }
    specify { expect(reflection.build_attribute(owner, nil).name).to eq('field') }
    specify { expect(reflection.build_attribute(owner, nil).owner).to eq(owner) }
  end

  describe '#type' do
    before { stub_class(:dummy, String) }

    specify { expect { reflection.type }.to raise_error('Type is not specified for `field`') }
    specify { expect(reflection(type: String).type).to eq(String) }
    specify { expect(reflection(type: :string).type).to eq(String) }
    specify { expect(reflection(type: Dummy).type).to eq(Dummy) }
    specify { expect { reflection(type: :blabla).type }.to raise_error NameError }
  end
end

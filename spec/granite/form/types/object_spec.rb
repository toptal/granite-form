# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Granite::Form::Types::Object do
  subject(:type) { described_class.new(String, reflection, model.new) }
  let(:model) { stub_model }
  let(:reflection) { Granite::Form::Model::Attributes::Reflections::Base.new(:field) }

  describe '#initialize' do
    it { is_expected.to have_attributes(type: String, reflection: reflection, owner: an_instance_of(model)) }
  end

  describe 'typecasting' do
    before { stub_class(:descendant) }

    context 'with Object type' do
      include_context 'type setup', 'Object'

      specify { expect(typecast('hello')).to eq('hello') }
      specify { expect(typecast([])).to eq([]) }
      specify { expect(typecast(Descendant.new)).to be_a(Descendant) }
      specify { expect(typecast(Object.new)).to be_a(Object) }
      specify { expect(typecast(nil)).to be_nil }
    end

    context 'with Descendant type' do
      include_context 'type setup', 'Descendant'

      before { stub_class(:descendant2, Descendant) }

      specify { expect(typecast('hello')).to be_nil }
      specify { expect(typecast([])).to be_nil }
      specify { expect(typecast(Descendant.new)).to be_a(Descendant) }
      specify { expect(typecast(Descendant2.new)).to be_a(Descendant2) }
      specify { expect(typecast(Object.new)).to be_nil }
      specify { expect(typecast(nil)).to be_nil }
    end
  end
end

require 'spec_helper'

describe Granite::Form::Config do
  subject { Granite::Form::Config.send :new }

  describe '#include_root_in_json' do
    its(:include_root_in_json) { should == false }
    specify do
      expect { subject.include_root_in_json = true }
        .to change { subject.include_root_in_json }.from(false).to(true)
    end
  end

  describe '#i18n_scope' do
    its(:i18n_scope) { should == :granite }
    specify do
      expect { subject.i18n_scope = :data_model }
        .to change { subject.i18n_scope }.from(:granite).to(:data_model)
    end
  end

  describe '#logger' do
    its(:logger) { should be_a Logger }
  end

  describe '#primary_attribute' do
    its(:primary_attribute) { should == :id }
    specify do
      expect { subject.primary_attribute = :identified }
        .to change { subject.primary_attribute }.from(:id).to(:identified)
    end
  end

  describe '#normalizer' do
    specify do
      expect { subject.normalizer(:name) {} }
        .to change {
          begin
            subject.normalizer(:name)
          rescue Granite::Form::NormalizerMissing
            nil
          end
        }.from(nil).to(an_instance_of(Proc))
    end
    specify { expect { subject.normalizer(:wrong) }.to raise_error Granite::Form::NormalizerMissing }
  end

  describe '#typecaster' do
    specify do
      expect { subject.typecaster('Object') {} }
        .to change { muffle(Granite::Form::TypecasterMissing) { subject.typecaster(Time, Object) } }
        .from(nil).to(an_instance_of(Proc))
    end
    specify do
      expect { subject.typecaster('Object') {} }
        .to change { muffle(Granite::Form::TypecasterMissing) { subject.typecaster('time', 'object') } }
        .from(nil).to(an_instance_of(Proc))
    end
    specify do
      expect { subject.typecaster('Object') {} }
        .to change { muffle(Granite::Form::TypecasterMissing) { subject.typecaster(Object) } }
        .from(nil).to(an_instance_of(Proc))
    end
    specify { expect { subject.typecaster(Object) }.to raise_error Granite::Form::TypecasterMissing }
  end
end

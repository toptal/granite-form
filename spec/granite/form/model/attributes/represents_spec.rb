require 'spec_helper'

describe Granite::Form::Model::Attributes::Represents do
  before do
    stub_model :author
    stub_model(:model) do
      def author
        @author ||= Author.new
      end
    end
  end

  let(:model) { Model.new }
  let(:attribute) { add_attribute }

  def add_attribute(*args)
    options = args.extract_options!.reverse_merge(of: :author)
    name = args.first || :name
    reflection = Model.add_attribute(Granite::Form::Model::Attributes::Reflections::Represents, name, options)
    model.attribute(reflection.name)
  end

  describe '#initialize' do
    before { Author.attribute :name, String, default: 'Default Name' }

    let(:attributes) { {foo: 'bar'} }

    it { expect { Model.new(attributes) }.to_not change { attributes } }

    it { expect(attribute.read).to eq('Default Name') }
    it { expect(attribute.read_before_type_cast).to eq('Default Name') }

    it { expect(add_attribute(default: -> { 'Field Default' }).read).to eq('Default Name') }

    context 'when owner changes value after initialize' do
      before do
        attribute
        model.author.name = 'Changed Name'
      end

      it { expect(attribute.read).to eq('Default Name') }
      it { expect(attribute.read_before_type_cast).to eq('Default Name') }
    end
  end

  describe '#sync' do
    before do
      Author.attribute :name, String
      attribute.write('New name')
    end

    it { expect { attribute.sync }.to change { model.author.name }.from(nil).to('New name') }

    context 'when represented object does not respond to attribute name' do
      let(:attribute) { add_attribute(:unknown_attribute) }

      it { expect { attribute.sync }.not_to raise_error }
    end
  end

  describe '#changed?' do
    before { Author.attribute :name, Boolean }

    specify do
      expect(model).to receive(:name_changed?)
      expect(attribute).not_to be_changed
    end

    context 'when attribute has default value' do
      let(:attribute) { add_attribute default: -> { true } }

      specify do
        expect(model).not_to receive(:name_changed?)
        expect(attribute).to be_changed
      end
    end

    context 'when attribute has false as default value' do
      let(:attribute) { add_attribute default: false }

      specify do
        expect(model).not_to receive(:name_changed?)
        expect(attribute).to be_changed
      end
    end
  end

  describe 'typecasting' do
    before { Author.attribute :name, String }

    def typecast(value)
      attribute.write(value)
      attribute.read
    end

    it 'returns original value when it has right class' do
      expect(typecast('1')).to eq '1'
    end

    it 'returns converted value to a proper type' do
      expect(typecast(1)).to eq '1'
    end

    it 'ignores nil' do
      expect(typecast(nil)).to be_nil
    end
  end

  describe '#type_definition' do
    it { expect(add_attribute.type_definition).to have_attributes(type: Object, owner: model) }
    it { expect(add_attribute(type: String).type_definition).to have_attributes(type: String, owner: model) }

    context 'when defined in attribute' do
      before { Author.attribute :name, String }

      it { expect(add_attribute.type_definition).to have_attributes(type: String, owner: model) }
      it { expect(add_attribute(type: Integer).type_definition).to have_attributes(type: Integer, owner: model) }
    end

    context 'when defined in represented attribute' do
      before do
        stub_model(:real_author) do
          attribute :name, Boolean
        end
        Author.class_eval do
          include Granite::Form::Model::Representation
          represents :name, of: :subject

          def subject
            @subject ||= RealAuthor.new
          end
        end
      end

      it { expect(add_attribute.type_definition).to have_attributes(type: Boolean, owner: model) }
    end

    context 'when defined in references_many' do
      before do
        stub_class(:user, ActiveRecord::Base)
        Author.class_eval do
          include Granite::Form::Model::Associations
          references_many :users
        end
      end

      it do
        attribute = add_attribute(:user_ids)
        expect(attribute.type_definition).to be_a(Granite::Form::Types::Collection)
        expect(attribute.type_definition.subtype_definition).to have_attributes(type: Integer, owner: model)
      end
    end

    context 'when defined in collection' do
      before do
        Author.collection :users, String
      end

      it do
        attribute = add_attribute(:users)
        expect(attribute.type_definition).to be_a(Granite::Form::Types::Collection)
        expect(attribute.type_definition.subtype_definition).to have_attributes(type: String, owner: model)
      end
    end

    context 'when defined in dictionary' do
      before do
        Author.dictionary :numbers, Float
      end

      it do
        attribute = add_attribute(:numbers)
        expect(attribute.type_definition).to be_a(Granite::Form::Types::Collection)
        expect(attribute.type_definition.subtype_definition).to have_attributes(type: Float, owner: model)
      end
    end

    context 'when defined in ActiveRecord::Base' do
      before do
        stub_class(:author, ActiveRecord::Base) do
          alias_attribute :full_name, :name
        end
      end

      it { expect(add_attribute.type_definition).to have_attributes(type: String, owner: model) }
      it { expect(add_attribute(:status).type_definition).to have_attributes(type: Integer, owner: model) }
      it { expect(add_attribute(:full_name).type_definition).to have_attributes(type: String, owner: model) }
      it { expect(add_attribute(:unknown_attribute).type_definition).to have_attributes(type: Object, owner: model) }
      it do
        attribute = add_attribute(:related_ids)
        expect(attribute.type_definition).to be_a(Granite::Form::Types::Collection)
        expect(attribute.type_definition.subtype_definition).to have_attributes(type: Integer, owner: model)
      end

      context 'with enum' do
        before do
          if ActiveRecord.gem_version >= Gem::Version.new('7.0')
            Author.enum :status, once: 1, many: 2
          else
            Author.enum status: %i[once many]
          end
        end

        it { expect(add_attribute(:status).type_definition).to have_attributes(type: String, owner: model) }
      end

      context 'with serialized attribute' do
        before { Author.serialize :data }

        it { expect(add_attribute(:data).type_definition).to have_attributes(type: Object, owner: model) }
      end
    end
  end
end

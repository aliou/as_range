require 'spec_helper'

RSpec.describe AsRange do
  describe '.included' do
    it 'extends the class methods to have the configuration method' do
      klass = Class.new do
        include AsRange
      end

      expect(klass).to respond_to(:as_range)
    end
  end

  describe '.as_range' do
    let(:klass) do
      Class.new do
        include AsRange
        as_range

        attr_accessor :start_date
        attr_accessor :end_date
      end
    end

    let(:instance) { klass.new }

    context 'without options' do
      it 'defines a as_range method' do
        expect(instance).to respond_to(:as_range)
      end

      it 'includes the end of the range' do
        instance.start_date = Faker::Date.backward
        instance.end_date = Faker::Date.forward

        range = instance.as_range
        expect(range.end).to eq(instance.end_date)
      end
    end

    context 'when setting the method name' do
      let(:method_name) { Faker::Lorem.word }

      let(:klass) do
        name = method_name
        Class.new do
          include AsRange
          as_range method_name: name
        end
      end

      it 'does not define a as_range method' do
        expect(instance).to_not respond_to(:as_range)
      end

      it 'defines the given method' do
        expect(instance).to respond_to(method_name)
      end
    end

    context 'when setting the start attribute' do
      let(:klass) do
        start_attribute_value = start_attribute

        Class.new do
          include AsRange
          as_range start: start_attribute_value

          attr_accessor :start_value
          attr_accessor :end_date
        end
      end
      let(:value) { Faker::Date.backward }

      context 'when setting the start_attribute as a callable' do
        let(:start_attribute) { -> { value } }

        it 'uses the callback return value' do
          instance.end_date = Faker::Date.forward
          range = instance.as_range
          expect(range.begin).to eq(value)
        end
      end

      context 'when setting the start_attribute as a sendable' do
        let(:start_attribute) { :start_value }

        it 'calls the sendable' do
          instance.start_value = value
          instance.end_date = Faker::Date.forward
          range = instance.as_range

          expect(range.begin).to eq(value)
        end
      end
    end

    context 'when setting the end attribute' do
      let(:klass) do
        name = end_attribute

        Class.new do
          include AsRange
          as_range end: name

          attr_accessor :start_date
          attr_accessor :end_value
        end
      end
      let(:value) { Faker::Date.forward }

      context 'when setting the end_attribute as a callable' do
        let(:end_attribute) { -> { value } }

        it 'uses the callback return value' do
          instance.start_date = Faker::Date.backward
          range = instance.as_range

          expect(range.end).to eq(value)
        end
      end

      context 'when setting the end_attribute as a sendable' do
        let(:end_attribute) { :end_value }

        it 'calls the sendable' do
          instance.start_date = Faker::Date.backward
          instance.end_value = value
          range = instance.as_range

          expect(range.end).to eq(value)
        end
      end
    end
  end
end

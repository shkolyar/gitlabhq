require 'spec_helper'

describe Uniquify, models: true do
  let(:uniquify) { described_class.new }

  describe "#string" do
    it 'returns the given string if it does not exist' do
      result = uniquify.string('test_string') { |s| false }

      expect(result).to eq('test_string')
    end

    it 'returns the given string with a counter attached if the string exists' do
      result = uniquify.string('test_string') { |s| s == 'test_string' }

      expect(result).to eq('test_string1')
    end

    it 'increments the counter for each candidate string that also exists' do
      result = uniquify.string('test_string') { |s| s == 'test_string' || s == 'test_string1' }

      expect(result).to eq('test_string2')
    end

    it 'allows passing in a base function that defines the location of the counter' do
      result = uniquify.string(-> (counter) { "test_#{counter}_string" }) do |s|
        s == 'test__string'
      end

      expect(result).to eq('test_1_string')
    end
  end
end

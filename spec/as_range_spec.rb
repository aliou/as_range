require 'spec_helper'

RSpec.describe AsRange do
  context 'when the as_range file is included' do
    it 'defines the as_range method' do
      klass = Class.new
      expect(klass).to respond_to(:as_range)
    end
  end
end

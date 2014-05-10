require 'spec_helper'

describe Dydx::Algebra::Set::Tan do
  describe '#to_s' do
    it{ expect(tan(:x).to_s).to eq('tan( x )') }
  end

  describe '#differentiate' do
  end

  describe 'Calculate' do
  end
end
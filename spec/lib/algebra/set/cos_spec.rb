require 'spec_helper'

describe Dydx::Algebra::Set::Cos do
  it { expect(cos(0).to_s).to eq('1') }
  it { expect(cos(pi).to_s).to eq('-1') }
  it { expect(cos(2 * pi).to_s).to eq('1') }

  describe '#to_s' do
    it { expect(cos(:x).to_s).to eq('cos( x )') }
  end

  describe '#differentiate' do
    it { expect(cos(:x).d.to_s).to eq('( - sin( x ) )') }
  end

  describe 'Calculate' do
  end
end

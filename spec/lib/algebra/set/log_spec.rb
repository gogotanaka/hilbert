require 'spec_helper'

describe Dydx::Algebra::Set::Log do
  it { expect(log(1)).to eq(_(0)) }
  it { expect(log(e)).to eq(_(1)) }
  it { expect(log(e ^ :n)).to eq(:n) }

  describe '#to_s' do
  end

  describe '#differentiate' do
    it { expect(log(:x).d(:x).to_s).to eq('( 1 / x )') }
  end

  describe 'Calculate' do
  end
end

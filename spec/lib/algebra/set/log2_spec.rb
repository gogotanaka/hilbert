require 'spec_helper'

describe Dydx::Algebra::Set::Log2 do
  it { expect(log2(1)).to eq(_(0)) }
  it { expect(log2(2)).to eq(_(1)) }
  it { expect(log2(2 ^ :n)).to eq(:n) }
  it { expect(log2(3 ^ :n).to_s).to eq('( n * log2( 3 ) )') }

  describe '#to_s' do
  end
  describe '#differentiate' do
    it { expect(log2(:x).d(:x).to_s).to eq('( 1 / ( x * log( 2 ) ) )') }
  end
  describe 'Calculate' do
  end
end

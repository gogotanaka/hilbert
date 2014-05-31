require 'spec_helper'

describe Dydx::Algebra::Set::Log10 do
  it { expect(log10(1)).to eq(_(0)) }
  it { expect(log10(10)).to eq(_(1)) }
  it { expect(log10(10 ^ :n)).to eq(:n) }
  it { expect(log10(3 ^ :n).to_s).to eq('( n * log10( 3 ) )') }

  describe '#to_s' do
  end
  describe '#differentiate' do
    it { expect(log10(:x).d(:x).to_s).to eq('( 1 / ( x * log( 10 ) ) )') }
  end
  describe 'Calculate' do
  end
end

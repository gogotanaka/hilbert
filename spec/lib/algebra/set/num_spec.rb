require 'spec_helper'

describe Dydx::Algebra::Set::Num do
  it{ expect(_(1)).to eq(_(1)) }
  it{ expect(_(-1)).to eq(_(-1)) }

  describe '#to_s' do
    it{ expect(_(1).to_s).to eq('1') }
  end

  describe '#differentiate' do
    it{ expect(_(1).d(:x).to_s).to eq(_(0).to_s) }
  end

  describe '#==' do
    it{ expect(_(1) == _(1)).to be_true }
  end

  describe 'Calculate' do
  end
end
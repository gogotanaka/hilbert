require 'spec_helper'

describe Dydx::Algebra::Set::Sin do
  it{ expect(sin(pi)).to eq(_(0)) }

  describe '#to_s' do
    it{ expect(sin(:x).to_s).to eq('sin( x )') }
  end
  describe '#differentiate' do
    it{ expect(sin(:x).d.to_s).to eq('cos( x )') }
  end
  describe 'Calculate' do
  end

  describe '#subst' do
    it{ expect(sin(x).subst(x: 3)).to eq(sin(3)) }
  end
end
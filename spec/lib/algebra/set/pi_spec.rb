require 'spec_helper'

describe Dydx::Algebra::Set::Pi do
  it{ expect(pi).to eq(pi) }

  describe '#to_s' do
    it{ expect(pi.to_s).to eq('pi') }
  end

  describe '#differentiate' do
    it{ expect(pi.d(:x).to_s).to eq(_(0).to_s) }
  end

  describe '#subst' do
    it{ expect(pi.subst).to eq(pi) }
  end

  describe 'Calculate' do
    context 'With Fixnum' do
      it{ expect(pi + 0).to eq(pi) }
      it{ expect(pi - 0).to eq(pi) }
      it{ expect((pi * 0).to_s).to eq('0') }
      it{ expect(pi * 1).to eq(pi) }
      it{ expect{(pi / 0).to_s}.to raise_error(ZeroDivisionError) }
      it{ expect(pi / 1).to eq(pi) }
      it{ expect((pi ^ 0).to_s).to eq('1') }
    end
  end
end

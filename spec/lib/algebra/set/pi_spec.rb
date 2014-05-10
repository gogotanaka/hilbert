require 'spec_helper'

describe Dydx::Algebra::Set::Pi do
  it{ expect(pi).to eq(pi) }
  it{ expect(pi.to_s).to eq('pi') }
  it{ expect(pi.d(:x).to_s).to eq(_(0).to_s) }

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

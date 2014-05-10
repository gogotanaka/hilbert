require 'spec_helper'

describe Dydx::Algebra::Set::E do
  it{ expect(e).to eq(e) }
  it{ expect(e.to_s).to eq('e') }
  it{ expect(e.d(:x).to_s).to eq(_(0).to_s) }

  context 'With Fixnum' do
    it{ expect(e + 0).to eq(e) }
    it{ expect(e - 0).to eq(e) }
    it{ expect((e * 0).to_s).to eq('0') }
    it{ expect(e * 1).to eq(e) }
    it{ expect{(e / 0).to_s}.to raise_error(ZeroDivisionError) }
    it{ expect(e / 1).to eq(e) }
    it{ expect((e ^ 0).to_s).to eq('1') }
  end
end
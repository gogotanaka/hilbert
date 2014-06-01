require 'spec_helper'

describe Dydx::Algebra::Set do
  it{ expect(_(1)).to eq(_(1)) }
  it{ expect(_(-1)).to eq(_(-1)) }
  it{ expect(e0).to eq(e0) }
  it{ expect(e1).to eq(e1) }

  it{ expect(e).to eq(e) }
  it{ expect(pi).to eq(pi) }

  it { expect(log10(1)).to eq(e0) }
  it { expect(log10(10)).to eq(e1) }
  it { expect(log10(10 ^ n)).to eq(n) }
  it { expect(log10(3 ^ n)).to eq(n * log10( 3 )) }

  it { expect(log2(1)).to eq(e0) }
  it { expect(log2(2)).to eq(e1) }
  it { expect(log2(2 ^ n)).to eq(n) }
  it { expect(log2(3 ^ n)).to eq(n * log2( 3 )) }

  it{ expect(log(1)).to eq(0) }
  it{ expect(log(e)).to eq(1) }
  it{ expect(log(e ^ n)).to eq(n) }

  it{ expect(sin(pi)).to eq(0) }

  it{ expect(cos(0)).to eq(1) }
  it{ expect(cos(pi)).to eq(-1) }
  it{ expect(cos(2 * pi)).to eq(1) }

  describe '#to_s' do


    it{ expect(e.to_s).to eq('e') }

    it{ expect(1.to_s).to eq('1') }

    it{ expect(1.0.to_s).to eq('1.0') }

    it{ expect(e1.to_s).to eq('1') }

    it{ expect(pi.to_s).to eq('pi') }

    it{ expect(cos(x).to_s).to eq('cos( x )') }
    it{ expect(sin(x).to_s).to eq('sin( x )') }
    it{ expect(tan(x).to_s).to eq('tan( x )') }

    it{ expect(x.to_s).to eq('x') }

  end

  describe '#==' do
    it{ expect(_(1) == _(1)).to be_true }
  end

  describe '#subst' do
    it{ expect(1.subst).to eq(1) }
    it{ expect(1.0.subst).to eq(1.0) }
    it{ expect(e.subst).to eq(e) }
    it{ expect(pi.subst).to eq(pi) }
    it{ expect(sin(x).subst(x: 3)).to eq(sin(3)) }
    it{ expect(cos(x).subst(x: pi)).to eq(-1) }
    it{ expect(tan(0).subst(x: pi)).to eq(0) }
    it{ expect(log(x).subst(x: e)).to eq(1) }
    it{ expect(log10(x).subst(x: 7)).to eq(log10(7)) }
    it{ expect(log2(2).subst(x: 2)).to eq(1) }
    it{ expect(x.subst(x: 2)).to eq(2) }
    it{ expect(x.subst(y: 2)).to eq(x) }
  end

  describe '#differentiate' do
    it { expect(e.d).to eq(0) }
    it { expect((e ^ x).d).to eq(e ^ x) }
    it { expect((e ^ (x + y)).d).to eq(e ^ ( x + y )) }

    it { expect(pi.d(x)).to eq(0) }

    it { expect(1.d).to eq(0) }
    it { expect(3.d).to eq(0) }
    it { expect(3.0.d).to eq(0) }

    it { expect(sin(x).d).to eq(cos(x)) }
    it { expect(cos(x).d).to eq(- sin(x)) }
    it { expect(tan(x).d).to eq(1 / cos(x) ^ 2) }

    it { expect(log(x).d).to eq(1 / x) }
    it { expect(log10(x).d).to eq(1 / ( x * log( 10 ) )) }
    it { expect(log2(x).d).to eq(1 / ( x * log( 2 ) )) }

    it{ expect(x.d(x)).to eq(1) }
  end

  describe 'Calculate' do
    context 'E with Fixnum' do
      it{ expect(e + 0).to eq(e) }
      it{ expect(e - 0).to eq(e) }
      it{ expect((e * 0).to_s).to eq('0') }
      it{ expect(e * 1).to eq(e) }
      it{ expect{(e / 0).to_s}.to raise_error(ZeroDivisionError) }
      it{ expect(e / 1).to eq(e) }
      it{ expect((e ^ 0).to_s).to eq('1') }
    end

    context 'Fixnum with Formula' do
      let(:formula) { (:x + :y) }
      it{ expect((0 + formula).to_s).to eq(formula.to_s) }
      it{ expect((0 - formula).to_s).to eq('( - ( x + y ) )') }
      it{ expect((0 * formula).to_s).to eq('0') }
      it{ expect((1 * formula).to_s).to eq(formula.to_s) }
      it{ expect((0 / formula).to_s).to eq('0') }
      it{ expect((1 / formula).to_s).to eq('( 1 / ( x + y ) )') }
      it{ expect((0 ^ formula).to_s).to eq('0') }
      it{ expect((1 ^ formula).to_s).to eq('1') }
    end

    context 'Fixnum with Symbol' do
      it{ expect(0 + :x).to eq(:x) }
      it{ expect((0 - :x).to_s).to eq('( - x )') }
      it{ expect((0 * :x).to_s).to eq('0') }
      it{ expect(1 * :x).to eq(:x) }
      it{ expect((0 / :x).to_s).to eq('0') }
      it{ expect((1 / :x).to_s).to eq('( 1 / x )') }
      it{ expect((0 ^ :x).to_s).to eq('0') }
      it{ expect((1 ^ :x).to_s).to eq('1') }
    end

    context 'Fixnum with Fixnum' do
      it{ expect(0 + 3).to eq(3) }
      it{ expect(3 + 0).to eq(3) }
      it{ expect(2 + 3).to eq(5) }

      it{ expect(0 - 3).to eq(-3) }
      it{ expect(3 - 0).to eq(3) }
      it{ expect(2 - 3).to eq(-1) }

      it{ expect(0 * 3).to eq(0) }
      it{ expect(3 * 0).to eq(0) }
      it{ expect(1 * 3).to eq(3) }
      it{ expect(3 * 1).to eq(3) }
      it{ expect(3 * 2).to eq(6) }

      it{ expect((0 / 3).to_s).to eq('0') }
      it{ expect{(3 / 0).to_s}.to raise_error(ZeroDivisionError) }
      it{ expect((3 / 1).to_s).to eq('3') }
      # TODO:
      it{ expect((2 / 3).to_s).to eq('0') }


      it{ expect((0 ^ 3).to_s).to eq('0') }
      it{ expect((3 ^ 0).to_s).to eq('1') }
      it{ expect((1 ^ 3).to_s).to eq('1') }
      it{ expect((3 ^ 1).to_s).to eq('3') }
      it{ expect((3 ^ 2).to_s).to eq('9') }
    end

    context 'Float with Formula' do
      let(:formula) { (:x + :y) }
      it{ expect((0.0 + formula).to_s).to eq(formula.to_s) }
      it{ expect((0.0 - formula).to_s).to eq('( - ( x + y ) )') }
      it{ expect((0.0 * formula).to_s).to eq('0') }
      it{ expect((1.0 * formula).to_s).to eq(formula.to_s) }
      it{ expect((0.0 / formula).to_s).to eq('0') }
      it{ expect((1.0 / formula).to_s).to eq('( 1 / ( x + y ) )') }
      it{ expect((0.0 ^ formula).to_s).to eq('0') }
      it{ expect((1.0 ^ formula).to_s).to eq('1') }
    end

    context 'Float with Symbol' do
      it{ expect(0.0 + :x).to eq(:x) }
      it{ expect((0.0 - :x).to_s).to eq('( - x )') }
      it{ expect((0.0 * :x).to_s).to eq('0') }
      it{ expect(1.0 * :x).to eq(:x) }
      it{ expect((0.0 / :x).to_s).to eq('0') }
      it{ expect((1.0 / :x).to_s).to eq('( 1 / x )') }
      it{ expect((0.0 ^ :x).to_s).to eq('0') }
      it{ expect((1.0 ^ :x).to_s).to eq('1') }
    end

    context 'Float with Float' do
      it{ expect(0.0 + 3.0).to eq(3.0) }
      it{ expect(3.0 + 0.0).to eq(3.0) }
      it{ expect(2.0 + 3.0).to eq(5.0) }

      it{ expect(0.0 - 3.0).to eq(-3.0) }
      it{ expect(3.0 - 0.0).to eq(3.0) }
      it{ expect(2.0 - 3.0).to eq(-1.0) }

      it{ expect(0.0 * 3.0).to eq(0.0) }
      it{ expect(3.0 * 0.0).to eq(0.0) }
      it{ expect(1.0 * 3.0).to eq(3.0) }
      it{ expect(3.0 * 1.0).to eq(3.0) }
      it{ expect(3.0 * 2.0).to eq(6.0) }

      it{ expect(0.0 / 3.0).to eq(0.0) }
      it{ expect(3.0 / 0.0).to eq(oo) }
      it{ expect(3.0 / 1.0).to eq(3.0) }
      # TODO:
      it{ expect(2.0 / 3.0).to eq(0.6666666666666666) }


      it{ expect(0.0 ^ 3.0).to eq(0.0) }
      it{ expect(3.0 ^ 0.0).to eq(1.0) }
      it{ expect(1.0 ^ 3.0).to eq(1.0) }
      it{ expect(3.0 ^ 1.0).to eq(3.0) }
      it{ expect(3.0 ^ 2.0).to eq(9.0) }
    end

    context 'Pi with Fixnum' do
      it{ expect(pi + 0).to eq(pi) }
      it{ expect(pi - 0).to eq(pi) }
      it{ expect((pi * 0).to_s).to eq('0') }
      it{ expect(pi * 1).to eq(pi) }
      it{ expect{(pi / 0).to_s}.to raise_error(ZeroDivisionError) }
      it{ expect(pi / 1).to eq(pi) }
      it{ expect((pi ^ 0).to_s).to eq('1') }
    end

    context 'Symbol with Fixnum' do
      it{ expect(:x + 0).to eq(:x) }
      it{ expect(:x - 0).to eq(:x) }
      it{ expect((:x * 0).to_s).to eq('0') }
      it{ expect(:x * 1).to eq(:x) }
      it{ expect{(:x / 0).to_s}.to raise_error(ZeroDivisionError) }
      it{ expect(:x / 1).to eq(:x) }
      it{ expect((:x ^ 0).to_s).to eq('1') }
      it{ expect(:x ^ 1).to eq(:x) }
    end
  end
end
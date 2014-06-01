require 'spec_helper'

describe Dydx::Algebra::Formula do
  let(:addition)       { (:x + :y) }
  let(:subtraction)    { (:x - :y) }
  let(:multiplication) { (:x * :y) }
  let(:division)       { (:x / :y) }
  let(:exponentiation) { (:x ^ :y) }
  describe 'Calculate' do
    context 'With Fixnum' do
      let(:formula) { (:x + :y) }
      it { expect(formula + 0).to eq(formula) }
      it { expect(formula - 0).to eq(formula) }
      it { expect(formula * 0).to eq(0) }
      it { expect(formula * 1).to eq(formula) }
      it { expect { (formula / 0).to_s }.to raise_error(ZeroDivisionError) }
      it { expect(formula / 1).to eq(formula) }
      it { expect(formula ^ 0).to eq(1) }
    end
  end

  describe '#to_s' do
    it { expect(addition.to_s).to eq('( x + y )') }
    it { expect(subtraction.to_s).to eq('( x - y )') }
    it { expect(multiplication.to_s).to eq('( x * y )') }
    it { expect(division.to_s).to eq('( x / y )') }
    it { expect(exponentiation.to_s).to eq('( x ^ y )') }
    it { expect((addition * multiplication).to_s).to eq('( ( x + y ) * ( x * y ) )') }
  end

  describe '#differentiate' do
    it { expect(addition.d(:x)).to eq(1) }
    it { expect(addition.d(:y)).to eq(1) }
    it { expect(addition.d(:z)).to eq(0) }

    it { expect(subtraction.d(:x)).to eq(1) }
    it { expect(subtraction.d(:y)).to eq('( - 1 )') }
    it { expect(subtraction.d(:z)).to eq(0) }

    it { expect(multiplication.d(:x)).to eq(:y) }
    it { expect(multiplication.d(:y)).to eq(:x) }
    it { expect(multiplication.d(:z)).to eq(0) }

    it { expect(division.d(:x)).to eq(1 / :y) }
    it { expect(division.d(:y)).to eq('( - ( x / ( y ^ 2 ) ) )') }
    it { expect(division.d(:z)).to eq(0) }

    it { expect(exponentiation.d(:x).to_s).to eq('( y * ( x ^ ( y - 1 ) ) )') }
    it { expect(exponentiation.d(:y)).to eq((:x ^ :y) * log(:x)) }
    it { expect(exponentiation.d(:z)).to eq(0) }
  end

  describe '#include?' do
    it { expect(addition.include?(:x)).to be_true }
    it { expect(addition.include?(:z)).to be_false }
  end

  describe '#openable?' do
    it { expect((:x + :y).openable?(:*, :x)).to be_true }
    it { expect((:x + :y).openable?(:*, :y)).to be_true }
    it { expect((:x + :y).openable?(:*, :z)).to be_false }
  end
end

require 'spec_helper'

describe Dydx::Formula do

  context 'With Fixnum' do
    let(:formula) { (:x + :y) }
    it{ expect((formula + 0).to_s).to eq(formula.to_s) }
    it{ expect((formula - 0).to_s).to eq(formula.to_s) }
    it{ expect((formula * 0).to_s).to eq('0') }
    it{ expect((formula * 1).to_s).to eq(formula.to_s) }
    it{ expect{(formula / 0).to_s}.to raise_error(ZeroDivisionError) }
    it{ expect(formula / 1).to eq(formula) }
    it{ expect((formula ^ 0).to_s).to eq('1') }
  end

  context '' do
    let(:formula) { (:x + :y) }
    it{ expect(((formula ^ 3) * (formula ^ 2)).to_s).to eq('( ( x + y ) ^ 5 )') }
  end

  let(:addition)      { (:x + :y) }
  let(:subtraction)   { (:x - :y) }
  let(:multiplication){ (:x * :y) }
  let(:division)      { (:x / :y) }
  let(:exponentiation){ (:x ^ :y) }

  it{ expect(addition.addition?).to be_true }
  it{ expect(subtraction.subtraction?).to be_true }
  it{ expect(multiplication.multiplication?).to be_true }
  it{ expect(division.division?).to be_true }
  it{ expect(exponentiation.exponentiation?).to be_true }

  it{ expect(addition.to_s).to eq('( x + y )') }
  it{ expect(subtraction.to_s).to eq('( x - y )') }
  it{ expect(multiplication.to_s).to eq('( x * y )') }
  it{ expect(division.to_s).to eq('( x / y )') }
  it{ expect(exponentiation.to_s).to eq('( x ^ y )') }
  it{ expect( (addition * multiplication).to_s ).to eq('( ( x + y ) * ( x * y ) )') }


  it{ expect(addition.d(:x).to_s).to eq('1') }
  it{ expect(addition.d(:y).to_s).to eq('1') }
  it{ expect(addition.d(:z).to_s).to eq('0') }

  it{ expect(subtraction.d(:x).to_s).to eq('1') }
  it{ expect(subtraction.d(:y).to_s).to eq('-1') }
  it{ expect(subtraction.d(:z).to_s).to eq('0') }

  it{ expect(multiplication.d(:x)).to eq(:y) }
  it{ expect(multiplication.d(:y)).to eq(:x) }
  it{ expect(multiplication.d(:z).to_s).to eq('0') }

  it{ expect(division.d(:x).to_s).to eq("( y ^ -1 )") }
  it{ expect(division.d(:y).to_s).to eq('( ( - x ) / ( y ^ 2 ) )') }
  it{ expect(division.d(:z).to_s).to eq('0') }

  it{ expect(exponentiation.d(:x).to_s).to eq('( y * ( x ^ ( y - 1 ) ) )') }
  it{ expect(exponentiation.d(:y).to_s).to eq('( ( x ^ y ) * log( x ) )') }
  it{ expect(exponentiation.d(:z).to_s).to eq('0') }

  it{ expect(exponentiation.d(:z).to_s).to eq('0') }

  it{ expect(log(:x).d(:x).to_s).to eq('( 1 / x )') }
  it{ expect(3.d(:x).to_s).to eq('0') }
  it{ expect((e ^ :x).d(:x).to_s).to eq('( e ^ x )') }
  it{ expect((e ^ addition).d(:x).to_s).to eq('( e ^ ( x + y ) )') }

  context 'With Symbol' do
    $a = (:x ^ :n)
    let(:d1){ da/dx }
    let(:d2){ d/dx($a) }
    it{ expect(d1.to_s).to eq('( n * ( x ^ ( n - 1 ) ) )') }
    it{ expect(d2.to_s).to eq('( n * ( x ^ ( n - 1 ) ) )') }
  end

  context 'With Symbol' do
    $b = (:x ^ (:x * 2))
    let(:d1){ db/dx }
    let(:d2){ d/dx($b) }
    it{ expect(d1.to_s).to eq('( ( x * 2 ) * ( x ^ ( ( x * 2 ) - 1 ) ) )') }
    it{ expect(d2.to_s).to eq('( ( x * 2 ) * ( x ^ ( ( x * 2 ) - 1 ) ) )') }
  end
end
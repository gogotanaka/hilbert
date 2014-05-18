require 'spec_helper'

describe Helper do
  it{ expect(0.is_0?).to be_true }
  it{ expect(_(0).is_0?).to be_true }
  it{ expect(inverse(0, :+).is_0?).to be_true }
  it{ expect(1.is_1?).to be_true }
  it{ expect(_(1).is_1?).to be_true }
  it{ expect(inverse(1, :*).is_1?).to be_true }
  it{ expect(-1.is_minus1?).to be_true }
  it{ expect(_(-1).is_minus1?).to be_true }

  it{ expect(0.is_multiple_of(:x).to_s).to eq('0') }
  it{ expect(_(0).is_multiple_of(:y).to_s).to eq('0')}

  it{ expect(:x.is_multiple_of(:x).to_s).to eq('1') }
  it{ expect(:x.is_multiple_of(:y)).to be_false }

  it{ expect((:x * :y).is_multiple_of(:x)).to eq(:y) }
  it{ expect((:x * :y).is_multiple_of(:y)).to eq(:x) }
  it{ expect((:x * :y).is_multiple_of(:z)).to be_false }

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

  it{ expect(inverse(:x, :+).inverse?(:x, :+)).to be_true }
  it{ expect(:x.inverse?(inverse(:x, :+), :+)).to be_true }
  it{ expect(inverse(:x, :*).inverse?(:x, :*)).to be_true }
  it{ expect(:x.inverse?(inverse(:x, :*), :*)).to be_true }
end
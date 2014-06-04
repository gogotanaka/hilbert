require 'spec_helper'

describe Helper do
  include Helper
  context '#is_n?' do
    it { expect(0.zero?).to be_true }
    it { expect(_(0).zero?).to be_true }
    it { expect(inverse(0, :+).zero?).to be_true }
    it { expect(1.one?).to be_true }
    it { expect(_(1).one?).to be_true }
    it { expect(inverse(1, :*).one?).to be_true }
    it { expect(-1.minus1?).to be_true }
    it { expect(_(-1).minus1?).to be_true }
  end

  context '#multiple_of?' do
    it { expect(0.multiple_of?(x)).to be(true) }

    it { expect(4.multiple_of?(_(2))).to be(true) }
    it { expect(_(4).multiple_of?(2)).to be(true) }
    it { expect(_(4).multiple_of?(_(2))).to be(true) }

    it { expect(x.multiple_of?(x)).to be(true) }
    it { expect(x.multiple_of?(y)).to be(false) }

    it { expect((x * y).multiple_of?(x)).to be(true) }
    it { expect((x * y).multiple_of?(x)).to be(true) }
    it { expect((x * y).multiple_of?(z)).to be(false) }
  end

  context '#like_term?' do
    it { expect(x.like_term?(x)).to be_true }
    it { expect((2 * x).like_term?((3 * x))).to be_true }
  end

  context '#combinable?' do
    it { expect(:x.combinable?(:x, :+)).to be_true }
    it { expect(:x.combinable?(2 * :x, :+)).to be_true }
    it { expect((2 * :x).combinable?(:x, :+)).to be_true }
    it { expect((2 * :x).combinable?(2 * :x, :+)).to be_true }
    it { expect(:x.combinable?(:y, :+)).to be_false }
    it { expect(1.combinable?(2, :+)).to be_true }
    it { expect(:x.combinable?(:x, :*)).to be_true }
    it { expect(:x.combinable?(:y, :*)).to be_false }
    it { expect(1.combinable?(2, :*)).to be_true }
    it { expect(0.combinable?(:x, :^)).to be_true }
    it { expect(1.combinable?(:y, :^)).to be_true }
  end

  context '#distributive?' do
    it { expect(distributive?(:+, :*)).to be_true }
    it { expect(distributive?(:+, :/)).to be_true }
    it { expect(distributive?(:-, :*)).to be_true }
    it { expect(distributive?(:-, :/)).to be_true }
    it { expect(distributive?(:*, :^)).to be_true }
    it { expect(distributive?(:/, :^)).to be_true }
    it { expect(distributive?(:*, :+)).to be_false }
    it { expect(distributive?(:^, :*)).to be_false }
  end

  let(:addition)       { (:x + :y) }
  let(:subtraction)    { (:x - :y) }
  let(:multiplication) { (:x * :y) }
  let(:division)       { (:x / :y) }
  let(:exponentiation) { (:x ^ :y) }

  it { expect(addition.addition?).to be_true }
  it { expect(multiplication.multiplication?).to be_true }
  it { expect(exponentiation.exponentiation?).to be_true }

  it { expect(inverse(:x, :+).inverse?(:+, :x)).to be_true }
  it { expect(:x.inverse?(:+, inverse(:x, :+))).to be_true }
  it { expect(inverse(:x, :*).inverse?(:*, :x)).to be_true }
  it { expect(:x.inverse?(:*, inverse(:x, :*))).to be_true }
end

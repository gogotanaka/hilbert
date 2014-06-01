require 'spec_helper'

describe Dydx::Algebra::Operator::Parts::Inverse do
  it { expect(inverse(:x, :+).to_s).to eq('( - x )') }
  it { expect(inverse(:x, :*).to_s).to eq('( 1 / x )') }

  it { expect(inverse(:x, :+)).to eq(inverse(:x, :+)) }
  it { expect(inverse(:x, :*)).to eq(inverse(:x, :*)) }

  it { expect(:x - :x).to eq(e0) }
  it { expect(:x / :x).to eq(e1) }
  it { expect(inverse(:x, :+) + :x).to eq(e0) }
  it { expect(inverse(:x, :*) * :x).to eq(e1) }
end

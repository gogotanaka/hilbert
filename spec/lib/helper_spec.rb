require 'spec_helper'

describe Helper do
  it{ expect(0.is_0?).to be_true }
  it{ expect(_(0).is_0?).to be_true }
  it{ expect(1.is_1?).to be_true }
  it{ expect(_(1).is_1?).to be_true }

  it{ expect(:x.is_multiple_of(:x)).to eq(1) }
  it{ expect(:x.is_multiple_of(:y)).to be_false }

  it{ expect((:x * :y).is_multiple_of(:x)).to eq(:y) }
  it{ expect((:x * :y).is_multiple_of(:y)).to eq(:x) }
  it{ expect((:x * :y).is_multiple_of(:z)).to be_false }
end
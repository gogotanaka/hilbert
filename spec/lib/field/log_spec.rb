require 'spec_helper'

describe Dydx::Field::Log do
  it{ expect(log(1)).to eq(_(0)) }
  it{ expect(log(e)).to eq(_(1)) }
  it{ expect(log(e ^ :n)).to eq(:n) }
end
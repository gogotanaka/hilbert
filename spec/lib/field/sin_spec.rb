require 'spec_helper'

describe Dydx::Field::Sin do
  it{ expect(sin(:x).to_s).to eq('sin( x )') }
  it{ expect(sin(pi)).to eq(_(0)) }
end
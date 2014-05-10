require 'spec_helper'

describe Dydx::Algebra::Operator::Parts::Base do
  it{ expect((:x + :x).to_s).to eq('( 2 * x )') }
  it{ expect((:x - :x).to_s).to eq('0') }
  it{ expect((:x * :x).to_s).to eq('( x ^ 2 )') }
  it{ expect((:x / :x).to_s).to eq('1') }
end
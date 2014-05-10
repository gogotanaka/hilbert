require 'spec_helper'

describe Dydx::Algebra::Set::Tan do
  it{ expect(tan(:x).to_s).to eq('tan( x )') }
end
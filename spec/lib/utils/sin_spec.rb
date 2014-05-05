require 'spec_helper'

describe Dydx::Sin do
  it{ expect(sin(:x).to_s).to eq('sin( x )') }
end
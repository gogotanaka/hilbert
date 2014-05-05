require 'spec_helper'

describe Dydx::Cos do
  it{ expect(cos(:x).to_s).to eq('cos( x )') }
end
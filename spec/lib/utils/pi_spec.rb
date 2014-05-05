require 'spec_helper'

describe Dydx::Pi do
  it{ expect(pi.d(:x).to_s).to eq('0') }
  it{ expect(pi.to_s).to eq('π') }
  it{ expect(pi).to eq(pi) }
end
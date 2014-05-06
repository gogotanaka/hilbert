require 'spec_helper'

describe Dydx::Pi do
  it{ expect(pi).to eq(pi) }
  it{ expect(pi.to_s).to eq('π') }
  it{ expect(pi.d(:x).to_s).to eq(_(0).to_s) }
end
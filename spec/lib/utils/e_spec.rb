require 'spec_helper'

describe Dydx::E do
  it{ expect(e).to eq(e) }
  it{ expect(e.to_s).to eq('e') }
  it{ expect(e.d(:x).to_s).to eq(_(0).to_s) }
end
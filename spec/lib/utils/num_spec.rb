require 'spec_helper'
describe Dydx::Num do
  it{ expect(_(1).n).to eq(1) }
  it{ expect(_(1).d(:x).to_s).to eq('0') }
end
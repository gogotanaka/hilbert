require 'spec_helper'

describe Dydx::Delta do
  it { expect(d.class).to eq(Delta) }
  it { expect(dx.class).to eq(Delta) }
  it { expect(dx.var).to eq(:x) }
  it { expect(dx(y).class).to eq(Delta) }
  it { expect(dx(y).var).to eq(:x) }
  it { expect(dx(y).function).to eq(:y) }
  it { expect { dxy }.to raise_error(NameError) }
end

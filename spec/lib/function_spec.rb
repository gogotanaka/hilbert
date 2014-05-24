require 'spec_helper'

describe Dydx:Function do
  # TODO: refactor
  it{ expect(f(x, y)).to eq(f(x, y)) }
  it{ expect(f(x, y)).to eq($f) }
  it{ expect(f(x, y).algebra).to be_nil }
  it{ expect(f(x, y).vars).to eq([:x, :y]) }
  it{ expect{f(x, y, z)}.to raise_error(ArgumentError) }
  it{ expect{f(x)}.to raise_error(ArgumentError) }
  it{ expect(f(x, y) <= x * y ).to eq(f(x, y)) }
  it{ expect(f(x, y)).to eq(f(x, y)) }
  it{ expect(f(x, y)).to eq($f) }
  it{ expect(f(x, y).algebra).to eq(x * y) }
  it{ expect(f(x, y)).to eq(x * y) }
  it{ expect(eval(f(x, y).to_s)).to eq(f(x, y)) }
  it{ expect(f(x, y)).to eq(eval(f(x, y).to_s)) }
  it{ expect(f(a, b)).to eq(a * b) }
  it{ expect(f(2, 3)).to eq(6) }
  it{ expect(f(a + b, c)).to eq((a + b) * c) }
  it{ expect(d/dx(f(x, y))).to eq(y) }
  it{ expect(d/dy(f(x, y))).to eq(x) }
  it{ expect(d/dz(f(x, y))).to eq(0) }

  it{ expect(g(a, b) <= f(a + b, b)).to eq(g(a, b)) }
  it{ expect(g(a, b)).to eq($g) }
  it{ expect(g(2, 3)).to eq(15) }
end

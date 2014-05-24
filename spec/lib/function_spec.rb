require 'spec_helper'

describe Dydx:Function do
  # TODO: refactor
  it{ expect(f(x, y)).to eq(f(x, y)) }
  it{ expect(f(x, y)).to eq($f) }
  it{ expect{f(x, y, z)}.to raise_error(ArgumentError) }
  it{ expect{f(x)}.to raise_error(ArgumentError) }
  it{ expect(f(x, y) <= x * y ).to eq(f(x, y)) }
  it{ expect(f(x, y)).to eq(f(x, y)) }
  it{ expect(f(x, y)).to eq($f) }
  it{ expect(f(a, b)).to eq(a * b) }
  it{ expect(f(2, 3)).to eq(6) }
  it{ expect(f(a + b, c)).to eq((a + b) * c) }
  it{ expect(d/dx(f(x, y))).to eq(y) }
  it{ expect(d/dy(f(x, y))).to eq(x) }
  it{ expect(d/dz(f(x, y))).to eq(0) }
end

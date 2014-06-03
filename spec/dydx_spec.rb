require 'spec_helper'

describe Dydx do
  it 'has a version number' do
    expect(Dydx::VERSION).not_to be nil
  end

  it 'demo' do
    f(x, y) <= x + x * y + y
    expect(f(x, y)).to eq(x * (1 + y) + y)
    expect(f(a, 2)).to eq(3 * a + 2)
    expect(f(1, a + b)).to eq(1 + 2 * ( a + b ))
    expect(f(1, 2)).to eq(5)
    expect(d/dx(f(x, y))).to eq(1 + y)

    g(x) <= sin(x)
    expect(d/dx(g(x))).to eq(cos(x))
    expect(S(g(x), dx)[0, pi / 2]).to eq(1.0)
  end
end

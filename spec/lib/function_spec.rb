require 'spec_helper'

describe Dydx::Function do
  before { reset }

  it 'ex1' do
    expect(f(x, y)).to eq(f(x, y))
    expect(f(x, y)).to eq($f)
    expect(f(x, y).algebra).to be_nil
    expect(f(x, y).vars).to eq([:x, :y])
    expect { f(x, y, z) }.to raise_error(ArgumentError)
    expect { f(x) }.to raise_error(ArgumentError)
  end

  it 'ex2' do
    expect(f(x, y) <= x * y ).to eq(f(x, y))
    expect(f(x, y)).to eq(f(x, y))
    expect(f(x, y)).to eq($f)
    expect(f(x, y).algebra).to eq(x * y)
    expect(f(x, y)).to eq(x * y)
    expect(f(x, y)).to eq(eval(f(x, y).to_s))
    expect(f(a, b)).to eq(a * b)
    expect(f(2, x)).to eq(2 * x)
    expect(f(2, 3)).to eq(6)
    expect(f(a + b, c)).to eq((a + b) * c)
    expect(d/dx(f(x, y))).to eq(y)
    expect(d/dy(f(x, y))).to eq(x)
    expect(d/dz(f(x, y))).to eq(0)
  end

  it 'ex3' do
    f(x, y) <= x * y
    g(a, b) <= f(a + b, b)
    expect(g(a, b)).to eq((a + b) * b)
    expect(g(a, 3)).to eq(9 + 3 * a)
    expect(g(2, 3)).to eq(15)
  end

  it 'ex4' do
    f(a, b) <= (a + b) * b
    h(a, b, c) <= d/db(f(a, b))
    expect(h(a, b, c)).to eq(( a + ( 2 * b ) ))
    expect(h(a, b, c).algebra).to eq(( a + ( 2 * b ) ))
  end

  it 'ex5' do
    f(x) <= log(x)
    expect(f(e)).to eq(1)
    expect(f(0)).to eq(-oo)
    expect(f(y)).to eq(log(y))

    g(x) <= d/dx(f(x))
    expect(g(1)).to eq(1)
  end

  it 'ex6' do
    f(x) <= sin(x)
    expect(f(pi)).to eq(0)
    expect(f(pi / 2)).to eq(1)
    expect(f(y)).to eq(sin(y))

    g(x) <= d/dx(f(x))
    expect(g(pi)).to eq(-1)
  end
end

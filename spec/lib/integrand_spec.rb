require 'spec_helper'

describe Dydx:Integrand do
  it 'ex1' do
    f(x, y) <= x * y
    integrand = S(f(x, y), dx)
    expect(integrand.function).to eq(f(x, y))
    expect(integrand.var).to eq(:x)
    expect{integrand[4, 3]}.to raise_error(ArgumentError)
  end

  it 'ex2' do
    $f = nil
    f(x) <= x * x
    expect(S(f(x), dx)[0, 1]).to eq(0.3333333333333334)
  end

  it 'ex3' do
    $f = nil
    f(x) <= sin(x)
    expect(S(f(x), dx)[0, Math::PI/2]).to eq(1.000000000021139)
  end

  it 'ex4' do
    $f = nil
    f(x) <= cos(x)
    expect(S(f(x), dx)[0, Math::PI]).to eq(7.440786129085082e-17)
  end

  it 'ex5' do
    $f = nil
    f(x) <= log(x)
    expect(S(f(x), dx)[0, 1]).to eq(- Float::INFINITY)
  end

  # TODO
  it 'ex6' do
    $f = nil
    f(x) <= e ^ (- (x^2))
    expect(S(f(x), dx)[-100, 100]).to eq(1.672428604536991)
  end
end

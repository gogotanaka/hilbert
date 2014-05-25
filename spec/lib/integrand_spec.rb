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
    expect(S(f(x), dx)[0, 1]).to eq(-oo)
  end

  it 'ex6' do
    $f = nil
    f(x) <= e ^ (- (x ^ 2))
    expect(f(0)).to eq(1)
    expect(f(1)).to eq(1.0/Math::E)
    expect(f(1000)).to eq(0)
    expect(S(f(x), dx)[-1000, 1000, 3000]).to eq(1.7724538506374117)
  end

  it 'ex7' do
    $f = nil
    f(x) <= (1.0 / ( ( 2.0 * Math::PI ) ^ 0.5 ) ) * ( e ^ (- (x ^ 2) / 2) )
    expect(S(f(x), dx)[-1000, 1000, 1000]).to eq(0.9952054164466917)
  end

  it 'ex8' do
    $f = nil
    f(x) <= (1.0 / ( ( 2.0 * pi ) ^ 0.5 ) ) * ( e ^ (- (x ^ 2) / 2) )
    expect(S(f(x), dx)[-oo, oo, 1000]).to eq(0.9952054164466917)
  end
end

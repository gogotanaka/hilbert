require 'spec_helper'

describe Dydx:Integrand do
  let(:integrand) do
    f(x, y) <= x * y
    integrand = S(f(x, y), dx)
  end
  it{ expect(integrand.function).to eq(f(x, y)) }
  it{ expect(integrand.var).to eq(:x) }
  it{ expect{integrand[4, 3]}.to raise_error(ArgumentError) }

  let(:integrand_2) do
    $f = nil
    f(x) <= x * x
    integrand = S(f(x), dx)
  end

  it{ expect(integrand_2[0, 1]).to eq(0.3333333333333334) }
end

require 'spec_helper'

describe Dydx::Delta do
  it { expect(d.class).to eq(Delta) }
  it { expect(dx.class).to eq(Delta) }
  it { expect(dx.var).to eq(:x) }
  it { expect(dx(y).class).to eq(Delta) }
  it { expect(dx(y).var).to eq(:x) }
  it { expect(dx(y).function).to eq(:y) }
  it { expect { dxy }.to raise_error(NameError) }

  before { reset }

  it 'ex1' do
    $y = x ** n
    expect(dy/dx).to eq( n * ( x ** ( n - 1 ) ) )
    expect(d/dx($y)).to eq( n * ( x ** ( n - 1 ) ) )
  end

  it 'ex2' do
    $y = x ** (x * 2)
    expect(dy/dx).to eq(( 2 * x ) * ( x ** ( ( 2 * x ) - 1 ) ))
    expect(d/dx($y)).to eq(( 2 * x ) * ( x ** ( ( 2 * x ) - 1 ) ))
  end

  it 'ex3' do
    $y = (t ** 2) / 2
    expect(dy/dt).to eq(t)
  end

  it 'ex4' do
    $y = 2 * (e ** (2 * z))
    expect(dy/dz).to eq(4 * ( e ** ( 2 * z ) ))
  end
end

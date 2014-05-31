require 'spec_helper'

describe Dydx:Delta do
  it{ expect(d.class).to eq(Delta) }
  it{ expect(dx.class).to eq(Delta) }
  it{ expect(dx.var).to eq(:x) }
  it{ expect(dx(y).class).to eq(Delta) }
  it{ expect(dx(y).var).to eq(:x) }
  it{ expect(dx(y).function).to eq(:y) }
  it{ expect{dxy}.to raise_error(NameError) }

  before(:each) do
    $y = example
  end

  context 'ex1' do
    let(:example) { x ^ n }
    it { expect(dy/dx).to eq( n * ( x ^ ( n - 1 ) ) ) }
    it { expect(d/dx($y)).to eq( n * ( x ^ ( n - 1 ) ) ) }
  end

  context 'ex2' do
    let(:example) { x ^ (x * 2) }
    it{ expect(dy/dx).to eq(( 2 * x ) * ( x ^ ( ( 2 * x ) - 1 ) )) }
    it{ expect(d/dx($y)).to eq(( 2 * x ) * ( x ^ ( ( 2 * x ) - 1 ) )) }
  end

  context 'ex3' do
    let(:example) { (t ^ 2) / 2 }
    it{ expect(dy/dt).to eq(t) }
  end

  context 'ex4' do
    let(:example) { 2 * (e ^ (2 * z)) }
    it{ expect(dy/dz).to eq(4 * ( e ^ ( 2 * z ) )) }
  end
end

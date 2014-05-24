require 'spec_helper'

describe Dydx do
  it 'has a version number' do
    expect(Dydx::VERSION).not_to be nil
  end

  context 'ex1' do
    $a = (:x ^ :n)
    let(:d1){ da/dx }
    let(:d2){ d/dx($a) }
    it{ expect(d1.to_s).to eq('( n * ( x ^ ( n - 1 ) ) )') }
    it{ expect(d2.to_s).to eq('( n * ( x ^ ( n - 1 ) ) )') }
  end

  context 'ex2' do
    $b = (:x ^ (:x * 2))
    let(:d1){ db/dx }
    let(:d2){ d/dx($b) }
    it{ expect(d1.to_s).to eq('( ( x * 2 ) * ( x ^ ( ( x * 2 ) - 1 ) ) )') }
    it{ expect(d2.to_s).to eq('( ( x * 2 ) * ( x ^ ( ( x * 2 ) - 1 ) ) )') }
  end

  context 'ex3' do
    $c = (:t ^ 2) / 2
    let(:d1){ dc/dt }
    let(:d2){ d/dt($c) }
    it{ expect(d1.to_s).to eq('t') }
    it{ expect(d2.to_s).to eq('t') }
  end

  context 'ex4' do
    $i = 2 * (e ^ (2 * :z))
    let(:d1){ di/dz }
    let(:d2){ d/dz($i) }
    it{ expect(d1.to_s).to eq('( 4 * ( e ^ ( 2 * z ) ) )') }
    it{ expect(d2.to_s).to eq('( 4 * ( e ^ ( 2 * z ) ) )') }
  end
end

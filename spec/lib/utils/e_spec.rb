describe Dydx::E do
  it{ expect(e.d(:x).to_s).to eq('0') }
  it{ expect(e.to_s).to eq('e') }
end
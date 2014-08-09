require 'spec_helper'

describe Qlang do
  it 'has a version number' do
    expect(Qlang::VERSION).not_to be nil
  end

  it 'has alias as Q' do
    expect(Qlang).to eq Q
  end

  describe Dydx do
    it 'check some example' do
      expect(d/dx(sin(x))).to eq cos(x)
    end
  end
end

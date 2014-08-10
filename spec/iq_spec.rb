require 'spec_helper'

describe Qlang do
  describe Iq do
    it do
      expect(Iq.execute('(1 2 3; 4 5 6)')).to eq('(1 2 3; 4 5 6)')
      expect(Iq.execute('(1 2 3; 4 5 6) + (1 2 3; 4 5 6)')).to eq('(2 4 6; 8 10 12)')
      expect(Iq.execute('(1 2 3)')).to eq('(1 2 3)')
      expect(Iq.execute('d/dx(sin(x))')).to eq(cos(x))
      expect(Iq.execute('d/dx(log(x))')).to eq(1/x)
      expect(Iq.execute('f(x, y) = x + y')).to eq(f(x, y) <= x + y)
    end
  end
end

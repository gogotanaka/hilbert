require 'spec_helper'

describe Qlang do
  describe Iq do
    it do
      expect(Iq.execute('d/dx(sin(x))')).to eq(cos(x))
      expect(Iq.execute('d/dx(log(x))')).to eq(1/x)
      expect(Iq.execute('f(x, y) = x + y')).to eq(f(x, y) <= x + y)
    end
  end
end

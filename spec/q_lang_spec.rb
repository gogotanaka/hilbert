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

      expect(
        Q.to_ruby.compile('d/dx(sin(x))')
      ).to eq(
        "d/dx(sin (x))"
      )

      expect(
        Q.to_ruby.compile('d/dx(log(x))')
      ).to eq(
        "d/dx(log (x))"
      )

      expect(
        Q.to_ruby.compile('f(x, y) = x + y')
      ).to eq(
        "f(x, y) <= x + y"
      )

      expect(
        Matrix[[1, 2, 3], [4, 5, 6]].to_q
      ).to eq(
        "(1 2 3; 4 5 6)"
      )

      expect(
        Vector[1, 2, 3].to_q
      ).to eq(
        "(1 2 3)"
      )
    end
  end
end

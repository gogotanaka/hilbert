require 'spec_helper'

describe Qlang do
  describe Iq do
    describe 'Matrix' do
      it do
        expect(Iq.execute('(1 2 3; 4 5 6)')).to eq('(1 2 3; 4 5 6)')
        expect(Iq.execute('(1 2 3; 4 5 6) + (1 2 3; 4 5 6)')).to eq('(2 4 6; 8 10 12)')
        expect(Iq.execute('(1 2 3; 4 5 6) - (2 4 1; 8 3 9)')).to eq('(-1 -2 2; -4 2 -3)')
        expect(Iq.execute('(1 2; 3 4) * (1 2; 3 4)')).to eq('(7 10; 15 22)')
        expect(Iq.execute('(1 2; 3 4) ** 2')).to eq('(7 10; 15 22)')
        expect(Iq.execute('(1 2; 3 4) * (1 2)')).to eq('(5 11)')
      end
    end

    describe 'Vector' do
      it do
        expect(Iq.execute('(1 2 3)')).to eq('(1 2 3)')
        expect(Iq.execute('(1 2 3) + (1 2 3)')).to eq('(2 4 6)')
        expect(Iq.execute('(1  2  3 )  +  ( 1 2 3 )')).to eq('(2 4 6)')
        expect(Iq.execute('(1 2 3) - (1 2 3) - (1 2 3)')).to eq('(-1 -2 -3)')
      end
    end

    describe 'List' do
      it do
      end
    end

    describe 'Diff' do
      it do
        expect(Iq.execute('d/dx(e ** x)')).to eq(e ** x)
        expect(Iq.execute('d/dx(x ** 2)')).to eq(2 * x)
        expect(Iq.execute('d/dx(x * 2)')).to eq(2)
        expect(Iq.execute('d/dx( sin(x) )')).to eq(cos(x))
        expect(Iq.execute('d/dx(log( x ))')).to eq(1/x)
      end
    end

    describe 'Integral' do
      it do
        expect(Iq.execute('S( log(x)dx )[0..1]')).to eq('-oo')
        expect(Iq.execute('S( sin(x)dx )[0..pi]')).to eq(2.0)
        expect(Iq.execute('S( cos(x)dx )[0..pi]')).to eq(0.0)
      end
    end

    describe 'Function' do
      it 'ex1' do
        expect(Iq.execute('f(x, y) = x + y')).to eq(f(x, y) <= x + y)
        expect(Iq.execute('f( 4, 5 )')).to eq(9)
      end

      it 'ex2' do
        expect(Iq.execute('f(x, y) = xy')).to eq(f(x, y) <= x * y)
        expect(Iq.execute('f( 3, 9 )')).to eq(27)
      end

      it 'ex3' do
        expect(Iq.execute('f(x, y) = xy^2')).to eq(f(x, y) <= x * y ** 2)
        expect(Iq.execute('f( 3, 2 )')).to eq(12)
      end

      it 'ex3' do
        expect(Iq.execute('f(x, y) = xy^2')).to eq(f(x, y) <= x * y ** 2)
        expect(Iq.execute('df/dx')).to eq(y ** 2)
      end

      it 'ex4' do
        expect(Iq.execute('g(x) = x ^ 2')).to eq(g(x) <= x ** 2)
        expect(Iq.execute('g(2)')).to eq(4)
      end
    end
  end
end

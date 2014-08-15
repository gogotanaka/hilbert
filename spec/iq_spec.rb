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
        expect(Iq.execute('d/dx(e ** x)')).to eq('e ^ x')
        expect(Iq.execute('d/dx(x ** 2)')).to eq('2x')
        expect(Iq.execute('d/dx(x * 2)')).to eq('2')
        expect(Iq.execute('d/dx( sin(x) )')).to eq('cos( x )')
        expect(Iq.execute('d/dx(log( x ))')).to eq('1 / x')
      end
    end

    describe 'Integral' do
      it do
        expect(Iq.execute('S( log(x)dx )[0..1]')).to eq('-oo')
        expect(Iq.execute('S( sin(x)dx )[0..pi]')).to eq('2.0')
        expect(Iq.execute('S( cos(x)dx )[0..pi]')).to eq('0.0')
        expect(Iq.execute('S( cos(x)dx )[0..pi]')).to eq('0.0')
      end
    end

    def self.iqtest(name, input, output)
      it name do
        expect(Iq.execute(input)).to eq(output)
      end
    end


    describe 'Function' do
      iqtest('ex1-def', 'f(x, y) = x + y', 'x + y')
      iqtest('ex1-cal', 'f( 4, 5 )', '9.0')

      iqtest('ex2-def', 'f(x, y) = xy', 'x * y')
      iqtest('ex2-cal', 'f( 3, 9 )', '27.0')

      iqtest('ex3-def', 'f(x, y) = xy^2', 'x * ( y ** 2 )')
      iqtest('ex3-cal', 'f( 3, 2 )', '12.0')

      iqtest('ex4-def', 'f(x, y) = xy^2', 'x * ( y ** 2 )')
      iqtest('ex4-cal', 'df/dx', 'y ^ 2')

      iqtest('ex5-def', 'g(x) = x ^ 2', 'x ** 2')
      iqtest('ex5-cal', 'g(2)', '4.0')

      iqtest('ex6-def', 'h(x) = e ^ 2', 'e ** 2')
      iqtest('ex6-cal', 'h(2)', '7.3890560989306495')

      iqtest('ex7-def', 'h(x) = pix', 'pi * x')
      iqtest('ex7-cal', 'h(3)', '9.42477796076938')

      iqtest('ex8-def', 'h(x) = pie', 'pi * e')
      iqtest('ex8-cal', 'h(2)', '8.539734222673566')

      iqtest('ex9-def', 'h(x) = ( 1 / ( 2pi ) ^( 1 / 2.0 ) ) * e ^ ( - x ^ 2 / 2 )', '( ( 4503599627370496 / 6369051672525773 ) / ( pi ** 0.5 ) ) * ( e ** ( ( - ( x ** 2 ) ) / 2 ) )')
      iqtest('ex9-cal', 'S( h(x)dx )[-oo..oo]', '1.0')
    end
  end
end

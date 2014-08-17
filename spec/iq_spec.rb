require 'spec_helper'

describe Qlang do
  describe Iq do
    def self.def_test(name, input, output)
      it name + '_def' do
        expect(Iq.execute(input)).to eq(output)
      end
    end

    def self.cal_test(name, input, output)
      it name + '_cal' do
        expect(Iq.execute(input)).to eq(output)
        reset
      end
    end

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
      cal_test('ex1', 'd/dx cos(x)', '- sin( x )')
      cal_test('ex2', 'd/dx xx', '2x')
    end

    describe 'Integral' do
      it do
        expect(Iq.execute('S( log(x)dx )[0..1]')).to eq('-oo')
        expect(Iq.execute('S( sin(x)dx )[0..pi]')).to eq('2.0')
        expect(Iq.execute('S( cos(x)dx )[0..pi]')).to eq('0.0')
        expect(Iq.execute('S( cos(x)dx )[0..pi]')).to eq('0.0')
      end
    end

    describe 'Function' do
      def_test('ex1', 'f(x, y) = x + y', 'x + y')
      cal_test('ex1', 'f( 4, 5 )', '9.0')

      def_test('ex2', 'f(x, y) = xy', 'x * y')
      cal_test('ex2', 'f( 3, 9 )', '27.0')

      def_test('ex3', 'f(x, y) = xy^2', 'x * ( y ** 2 )')
      cal_test('ex3', 'f( 3, 2 )', '12.0')

      def_test('ex4', 'f(x, y) = xy^2', 'x * ( y ** 2 )')
      cal_test('ex4', 'df/dx', 'y ^ 2')

      def_test('ex5', 'g(x) = x ^ 2', 'x ** 2')
      cal_test('ex5', 'g(2)', '4.0')

      def_test('ex6', 'h(x) = e ^ 2', 'e ** 2')
      cal_test('ex6', 'h(2)', '7.3890560989306495')

      def_test('ex7', 'h(x) = pix', 'pi * x')
      cal_test('ex7', 'h(3)', '9.42477796076938')

      def_test('ex8', 'h(x) = pie', 'pi * e')
      cal_test('ex8', 'h(2)', '8.539734222673566')

      def_test('ex9', 'h(x) = ( 1 / ( 2pi ) ^ ( 1 / 2.0 ) ) * e ^ ( - x ^ 2 / 2 )', '( ( 4503599627370496 / 6369051672525773 ) / ( pi ** 0.5 ) ) * ( e ** ( ( - ( x ** 2 ) ) / 2 ) )')
      cal_test('ex9', 'S( h(x)dx )[-oo..oo]', '1.0')

      def_test('ex10', 'f(x) = sin(x)', 'sin( x )')
      cal_test('ex10', 'f(pi)', '0.0')

      def_test('ex11', 'f(x) = cos(x)', 'cos( x )')
      cal_test('ex11', 'f(pi)', '-1.0')

      def_test('ex11', 'f(x) = log(x)', 'log( x )')
      cal_test('ex11', 'f(e)', '1.0')
    end
  end
end

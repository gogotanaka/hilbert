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

    describe 'General' do
      cal_test('ex1', '2x', '2x')
      cal_test('ex2', 'x + x', '2x')
      cal_test('ex3', 'x * y', 'xy')
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
      cal_test('ex1', 'S(xx dx)[0..1]', '0.33333333')
      cal_test('ex2', 'S(2pi dx)[0..1]', '6.28318531')
    end

  end
end

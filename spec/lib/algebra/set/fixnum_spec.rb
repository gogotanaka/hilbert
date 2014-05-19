require 'spec_helper'

describe Fixnum do
  describe '#to_s' do
    it{ expect(1.to_s).to eq('1') }
  end

  describe '#differentiate' do
    it{ expect(3.d(:x).to_s).to eq('0') }
  end

  describe 'Calculate' do
    context 'With Formula' do
      let(:formula) { (:x + :y) }
      it{ expect((0 + formula).to_s).to eq(formula.to_s) }
      it{ expect((0 - formula).to_s).to eq('( - ( x + y ) )') }
      it{ expect((0 * formula).to_s).to eq('0') }
      it{ expect((1 * formula).to_s).to eq(formula.to_s) }
      it{ expect((0 / formula).to_s).to eq('0') }
      it{ expect((1 / formula).to_s).to eq('( 1 / ( x + y ) )') }
      it{ expect((0 ^ formula).to_s).to eq('0') }
      it{ expect((1 ^ formula).to_s).to eq('1') }
    end

    context 'With Symbol' do
      it{ expect(0 + :x).to eq(:x) }
      it{ expect((0 - :x).to_s).to eq('( - x )') }
      it{ expect((0 * :x).to_s).to eq('0') }
      it{ expect(1 * :x).to eq(:x) }
      it{ expect((0 / :x).to_s).to eq('0') }
      it{ expect((1 / :x).to_s).to eq('( 1 / x )') }
      it{ expect((0 ^ :x).to_s).to eq('0') }
      it{ expect((1 ^ :x).to_s).to eq('1') }
    end

    context 'With Fixnum' do
      it{ expect(0 + 3).to eq(3) }
      it{ expect(3 + 0).to eq(3) }
      it{ expect(2 + 3).to eq(5) }

      it{ expect(0 - 3).to eq(-3) }
      it{ expect(3 - 0).to eq(3) }
      it{ expect(2 - 3).to eq(-1) }

      it{ expect(0 * 3).to eq(0) }
      it{ expect(3 * 0).to eq(0) }
      it{ expect(1 * 3).to eq(3) }
      it{ expect(3 * 1).to eq(3) }
      it{ expect(3 * 2).to eq(6) }

      it{ expect((0 / 3).to_s).to eq('0') }
      it{ expect{(3 / 0).to_s}.to raise_error(FloatDomainError) }
      it{ expect((3 / 1).to_s).to eq('3') }
      # TODO:
      it{ expect((2 / 3).to_s).to eq('0') }


      it{ expect((0 ^ 3).to_s).to eq('0') }
      it{ expect((3 ^ 0).to_s).to eq('1') }
      it{ expect((1 ^ 3).to_s).to eq('1') }
      it{ expect((3 ^ 1).to_s).to eq('3') }
      it{ expect((3 ^ 2).to_s).to eq('9') }
    end
  end
end

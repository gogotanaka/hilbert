require 'spec_helper'

describe Float do
  describe '#to_s' do
    it{ expect(1.0.to_s).to eq('1.0') }
  end

  describe '#differentiate' do
    it{ expect(3.0.d(:x).to_s).to eq('0') }
  end

  describe 'Calculate' do
    context 'With Formula' do
      let(:formula) { (:x + :y) }
      it{ expect((0.0 + formula).to_s).to eq(formula.to_s) }
      it{ expect((0.0 - formula).to_s).to eq('( - ( x + y ) )') }
      it{ expect((0.0 * formula).to_s).to eq('0') }
      it{ expect((1.0 * formula).to_s).to eq(formula.to_s) }
      it{ expect((0.0 / formula).to_s).to eq('0') }
      it{ expect((1.0 / formula).to_s).to eq('( 1 / ( x + y ) )') }
      it{ expect((0.0 ^ formula).to_s).to eq('0') }
      it{ expect((1.0 ^ formula).to_s).to eq('1') }
    end

    context 'With Symbol' do
      it{ expect(0.0 + :x).to eq(:x) }
      it{ expect((0.0 - :x).to_s).to eq('( - x )') }
      it{ expect((0.0 * :x).to_s).to eq('0') }
      it{ expect(1.0 * :x).to eq(:x) }
      it{ expect((0.0 / :x).to_s).to eq('0') }
      it{ expect((1.0 / :x).to_s).to eq('( 1 / x )') }
      it{ expect((0.0 ^ :x).to_s).to eq('0') }
      it{ expect((1.0 ^ :x).to_s).to eq('1') }
    end

    context 'With Float' do
      it{ expect(0.0 + 3.0).to eq(3.0) }
      it{ expect(3.0 + 0.0).to eq(3.0) }
      it{ expect(2.0 + 3.0).to eq(5.0) }

      it{ expect(0.0 - 3.0).to eq(-3.0) }
      it{ expect(3.0 - 0.0).to eq(3.0) }
      it{ expect(2.0 - 3.0).to eq(-1.0) }

      it{ expect(0.0 * 3.0).to eq(0.0) }
      it{ expect(3.0 * 0.0).to eq(0.0) }
      it{ expect(1.0 * 3.0).to eq(3.0) }
      it{ expect(3.0 * 1.0).to eq(3.0) }
      it{ expect(3.0 * 2.0).to eq(6.0) }

      it{ expect(0.0 / 3.0).to eq(0.0) }
      it{ expect(3.0 / 0.0).to eq(Float::INFINITY) }
      it{ expect(3.0 / 1.0).to eq(3.0) }
      # TODO:
      it{ expect(2.0 / 3.0).to eq(0.6666666666666666) }


      it{ expect(0.0 ^ 3.0).to eq(0.0) }
      it{ expect(3.0 ^ 0.0).to eq(1.0) }
      it{ expect(1.0 ^ 3.0).to eq(1.0) }
      it{ expect(3.0 ^ 1.0).to eq(3.0) }
      it{ expect(3.0 ^ 2.0).to eq(9.0) }
    end
  end
end

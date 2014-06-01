require 'spec_helper'

describe Symbol do
  describe '#to_s' do
    it { expect(:x.to_s).to eq('x') }
  end

  describe '#differentiate' do
    it { expect(:x.d(:x).to_s).to eq('1') }
  end

  describe 'Calculate' do
    context 'With Fixnum' do
      it { expect(:x + 0).to eq(:x) }
      it { expect(:x - 0).to eq(:x) }
      it { expect((:x * 0).to_s).to eq('0') }
      it { expect(:x * 1).to eq(:x) }
      it { expect { (:x / 0).to_s }.to raise_error(ZeroDivisionError) }
      it { expect(:x / 1).to eq(:x) }
      it { expect((:x ^ 0).to_s).to eq('1') }
      it { expect(:x ^ 1).to eq(:x) }
    end
  end
end

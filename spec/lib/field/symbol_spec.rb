require 'spec_helper'

describe Symbol do
  context 'With Fixnum' do
    it{ expect(:x + 0).to eq(:x) }
    it{ expect(:x - 0).to eq(:x) }
    it{ expect((:x * 0).to_s).to eq('0') }
    it{ expect(:x * 1).to eq(:x) }
    it{ expect{(:x / 0).to_s}.to raise_error(ZeroDivisionError) }
    it{ expect(:x / 1).to eq(:x) }
    it{ expect((:x ^ 0).to_s).to eq('1') }
    it{ expect(:x ^ 1).to eq(:x) }
  end
end
require 'spec_helper'

describe Hilbert do
  describe 'Vector' do
    context 'into R' do
      it do
        expect(
          Hilbert.to_r.compile('(1 2 3)')
        ).to eq(
          'c(1, 2, 3)'
        )

        expect(
          Hilbert.to_r.compile('(1 2 3 4 5 6)')
        ).to eq(
          'c(1, 2, 3, 4, 5, 6)'
        )

        expect(
          Hilbert.to_r.compile('(1   2    3  4      5   6)')
        ).to eq(
          'c(1, 2, 3, 4, 5, 6)'
        )
      end
    end

    context 'into Ruby' do
      it do
        expect(
          Hilbert.to_ruby.compile('(1 2 3)')
        ).to eq(
          'Vector[1, 2, 3]'
        )
      end
    end

    context 'into Python' do
      it do
        expect(
          Hilbert.to_python.compile('(1 2 3)')
        ).to eq(
          'array([1, 2, 3])'
        )
      end
    end
  end
end

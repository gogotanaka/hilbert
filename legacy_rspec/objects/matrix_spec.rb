require 'spec_helper'

describe Hilbert do
  describe 'Matrix' do
    context 'into R' do
      it do
        expect(
          Q.to_r.compile('(1 2 3; 4 5 6)')
        ).to eq(
          'matrix(c(1, 2, 3, 4, 5, 6), 2, 3, byrow = TRUE)'
        )

        expect(
          Q.to_r.compile('(1 2 3 ; 4 5 6)')
        ).to eq(
          'matrix(c(1, 2, 3, 4, 5, 6), 2, 3, byrow = TRUE)'
        )

        expect(
          Q.to_r.compile('(1 2 3 ; 4 5 6; 7 8 9)')
        ).to eq(
          'matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), 3, 3, byrow = TRUE)'
        )

        expect(
          Q.to_r.compile('(1;2;3)')
        ).to eq(
          'matrix(c(1, 2, 3), 3, 1, byrow = TRUE)'
        )
      end
    end

    context 'into Ruby' do
      it do
        expect(
          Q.to_ruby.compile('(1 2 3; 4 5 6)')
        ).to eq(
          'Matrix[[1, 2, 3], [4, 5, 6]]'
        )

        expect(
          Q.to_ruby.compile('(1 2 3 ; 4 5 6; 7 8 9)')
        ).to eq(
          'Matrix[[1, 2, 3], [4, 5, 6], [7, 8, 9]]'
        )

        expect(
          Q.to_ruby.compile('(1;2;3)')
        ).to eq(
          'Matrix[[1], [2], [3]]'
        )
      end
    end
  end
end

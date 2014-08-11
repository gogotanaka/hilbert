require 'spec_helper'

describe Qlang do
  describe 'Integral' do
    context 'into R' do
      it do

      end
    end
    context 'into Ruby' do
      it do
        expect(
          Q.to_ruby.compile('S( log(x)dx )[0..1]')
        ).to eq(
          'S(log(x), dx)[0, 1]'
        )
      end
    end
  end
end

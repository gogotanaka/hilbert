$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'q'
require 'pry'
describe Q do
  describe 'List' do
    it do
      expect(
        Q.compile('{name: "Gogotanaka", age:  21, birth: (1992 8 10) }')
      ).to eq(
        "list(name=\"Gogotanaka\", age=21, birth=c(1992, 8, 10))"
      )
    end
  end

  describe 'Matrix' do
    it do
      expect(
        Q.compile('(1 2 3; 4 5 6)')
      ).to eq(
        "matrix(c(1, 2, 3, 4, 5, 6), 2, 3, byrow = TRUE)"
      )
    end
  end

  describe 'Vector' do
    it do
      expect(
        Q.compile('(1 2 3)')
      ).to eq(
        "c(1, 2, 3)"
      )
    end
  end
end

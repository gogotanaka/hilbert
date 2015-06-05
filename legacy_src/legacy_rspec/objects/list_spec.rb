require 'spec_helper'

describe Hilbert do
  describe 'List' do
    it do
      # expect(
      #   Hilbert.to_r.compile('{name: "Gogotanaka", age:  21, birth: (1992 8 10) }')
      # ).to eq(
      #   "list(name=\"Gogotanaka\", age=21, birth=c(1992, 8, 10))"
      # )

      expect(
        Hilbert.to_r.compile('{key1: 234234, key2: 387342 }')
      ).to eq(
        'list(key1=234234, key2=387342)'
      )

      expect(
        Hilbert.to_r.compile('{key1:234234,key2:387342,key3:38733242}')
      ).to eq(
        'list(key1=234234, key2=387342, key3=38733242)'
      )

      # expect(
      #   Hilbert.to_r.compile('{key1:(1 3 2; 8 2 3),key2:387342,key3:38733242}')
      # ).to eq(
      #   "list(key1=matrix(c(1, 3, 2, 8, 2, 3), 2, 3, byrow = TRUE), key2=387342, key3=38733242)"
      # )
    end
  end
end

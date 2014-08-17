require '../spec_helper'

describe 'Regular expressions' do
  def self.should_match(num, rgx, str)
    it 'ex' + num.to_s do
      expect(rgx =~ str).to eq(0)
    end
  end
  describe 'function' do
    should_match(1, /[fgh]\(\w( ?, ?\w)*\) ?= ?[^\r\n]+/, 'f(x) = xy')
  end
end

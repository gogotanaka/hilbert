require 'spec_helper'

include Lexer::Tokens

describe 'Regular expressions' do
  def self.should_match(num, rgx, str)
    it 'ex' + num.to_s do
      expect(rgx =~ str).to eq(0)
      expect($&).to eq(str)
    end
  end

  def self.should_not_match(num, rgx, str)
    it 'ex' + num.to_s do
      expect(rgx =~ str).not_to eq(0)
    end
  end

  describe 'tokens' do
    describe 'nums' do
      should_match(1, NUM, '1')
      should_match(2, NUM, '234987423')
      should_match(3, NUM, '23423948.298743')
      should_match(4, NUM, 'e')
      should_match(5, NUM, 'pi')
      should_not_match(6, NUM, 'a')
    end
    describe 'vars' do
      # should_match(1, VAR_MUL, 'ab')
      # should_not_match(2, VAR_MUL, 'pi')
      # should_not_match(3, VAR_MUL, 'sin')
    end
  end


  describe 'function' do
    should_match(1, /[fgh]\(\w( ?, ?\w)*\) ?= ?[^\r\n]+/, 'f(x) = xy')
  end

  describe 'differentiate' do
    rgx = /d\/d[a-zA-Z] .*/
    should_match(1, rgx, 'd/dx sin(x)')
    should_match(2, rgx, 'd/dz z^2')
  end
end

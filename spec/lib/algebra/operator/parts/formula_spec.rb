require 'spec_helper'

describe Dydx::Algebra::Operator::Parts::Formula do
  it{ expect(((:a * :b) + (:a * :c)).to_s).to eq('( a * ( b + c ) )') }
  it{ expect(((:a * :b) + (:c * :a)).to_s).to eq('( a * ( b + c ) )') }
  it{ expect(((:b * :a) + (:c * :a)).to_s).to eq('( a * ( b + c ) )') }
  it{ expect(((:b * :a) + (:a * :c)).to_s).to eq('( a * ( b + c ) )') }
  it{ expect(((:a * :b) - (:a * :c)).to_s).to eq('( a * ( b - c ) )') }
  it{ expect(((:a * :b) - (:c * :a)).to_s).to eq('( a * ( b - c ) )') }
  it{ expect(((:b * :a) - (:c * :a)).to_s).to eq('( a * ( b - c ) )') }
  it{ expect(((:b * :a) - (:a * :c)).to_s).to eq('( a * ( b - c ) )') }

  it{ expect(((:a ^ :b) * (:a ^ :c)).to_s).to eq('( a ^ ( b + c ) )') }
  it{ expect(((:a ^ :b) * (:c ^ :a)).to_s).to eq('( ( a ^ b ) * ( c ^ a ) )') }
  it{ expect(((:b ^ :a) * (:c ^ :a)).to_s).to eq('( ( b * c ) ^ a )') }
  it{ expect(((:b ^ :a) * (:a ^ :c)).to_s).to eq('( ( b ^ a ) * ( a ^ c ) )') }
  it{ expect(((:a ^ :b) / (:a ^ :c)).to_s).to eq('( a ^ ( b - c ) )') }
  it{ expect(((:a ^ :b) / (:c ^ :a)).to_s).to eq('( ( a ^ b ) / ( c ^ a ) )') }
  it{ expect(((:b ^ :a) / (:c ^ :a)).to_s).to eq('( ( b / c ) ^ a )') }
  it{ expect(((:b ^ :a) / (:a ^ :c)).to_s).to eq('( ( b ^ a ) / ( a ^ c ) )') }

  it{ expect(((:x - 2) + 2).to_s).to eq('x') }
  it{ expect(((:x + 2) - 2).to_s).to eq('x') }
  it{ expect(((:x * 2) / 2).to_s).to eq('x') }
  it{ expect(((:x / 2) * 2).to_s).to eq('x') }

  it{ expect((2 + (:x - 2)).to_s).to eq('x') }
  it{ expect((2 - (:x + 2)).to_s).to eq('( - x )') }
  it{ expect((2 * (:x / 2)).to_s).to eq('x') }
  it{ expect((2 / (:x * 2)).to_s).to eq('( 1 / x )') }

  it{ expect(((:x + :y) + :y).to_s).to eq('( ( 2 * y ) + x )') }
  it{ expect(((:y + :x) + :y).to_s).to eq('( ( 2 * y ) + x )') }
  it{ expect(((:x - :y) - :y).to_s).to eq('( x - ( 2 * y ) )') }
  it{ expect(((:y - :x) - :y).to_s).to eq('( - x )') }
  it{ expect(((:y * :x) * :y).to_s).to eq('( ( y ^ 2 ) * x )') }
  it{ expect(((:x * :y) * :y).to_s).to eq('( ( y ^ 2 ) * x )') }
  it{ expect(((:x / :y) / :y).to_s).to eq('( x / ( y ^ 2 ) )') }
  it{ expect(((:y / :x) / :y).to_s).to eq('( 1 / x )') }

  it{ expect((:y + (:x + :y)).to_s).to eq('( ( 2 * y ) + x )') }
  it{ expect((:y + (:y + :x)).to_s).to eq('( ( 2 * y ) + x )') }
  it{ expect((:y - (:x - :y)).to_s).to eq('( ( 2 * y ) - x )') }
  it{ expect((:y - (:y - :x)).to_s).to eq('x') }
  it{ expect((:y * (:y * :x)).to_s).to eq('( ( y ^ 2 ) * x )') }
  it{ expect((:y * (:x * :y)).to_s).to eq('( ( y ^ 2 ) * x )') }
  it{ expect((:y - (:x - :y)).to_s).to eq('( ( 2 * y ) - x )') }
  it{ expect((:y - (:y - :x)).to_s).to eq('x') }

  it{ expect(((:x * 2) ^ 2).to_s).to eq('( 4 * ( x ^ 2 ) )') }
  it{ expect(((:x / 2) ^ 2).to_s).to eq('( ( x ^ 2 ) / 4 )') }

  it{ expect((3*x + 4*(x^2)+ 4*x).to_s).to eq('( ( 7 * x ) + ( 4 * ( x ^ 2 ) ) )') }

  # TODO:
  it{ expect((2 ^ (:x * 2)).to_s).to eq('( 2 ^ ( 2 * x ) )') }
  it{ expect((2 ^ (:x / 2)).to_s).to eq('( 2 ^ ( x / 2 ) )') }
end

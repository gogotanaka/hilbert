require 'spec_helper'

describe Dydx::Algebra::Operator::Parts::Formula do
  it{ expect(((:a * :b) + (:a * :c)).to_s).to eq('( a * ( b + c ) )') }
  it{ expect(((:b * :a) + (:c * :a)).to_s).to eq('( ( b + c ) * a )') }
  it{ expect(((:a * :b) - (:a * :c)).to_s).to eq('( a * ( b - c ) )') }
  it{ expect(((:b * :a) - (:c * :a)).to_s).to eq('( ( b - c ) * a )') }

  it{ expect(((:x ^ 3) * (:x ^ 2)).to_s).to eq('( x ^ 5 )') }
  it{ expect(((:x ^ 3) / (:x ^ 2)).to_s).to eq('x') }
  it{ expect(((:x ^ :n) * (:y ^ :n)).to_s).to eq('( ( x * y ) ^ n )') }
  it{ expect(((:x ^ :n) / (:y ^ :n)).to_s).to eq('( ( x / y ) ^ n )') }

  it{ expect(((:x - 2) + 2).to_s).to eq('x') }
  it{ expect(((:x + 2) - 2).to_s).to eq('x') }
  it{ expect(((:x * 2) / 2).to_s).to eq('x') }
  it{ expect(((:x / 2) * 2).to_s).to eq('x') }

  it{ expect(((:x + :y) + :y).to_s).to eq('( x + ( 2 * y ) )') }
  it{ expect(((:x - :y) - :y).to_s).to eq('( x - ( 2 * y ) )') }
  it{ expect(((:y - :x) - :y).to_s).to eq('( - x )') }
  it{ expect(((:x * :y) * :y).to_s).to eq('( x * ( y ^ 2 ) )') }
  it{ expect(((:x / :y) / :y).to_s).to eq('( x / ( y ^ 2 ) )') }
  it{ expect(((:y / :x) / :y).to_s).to eq('( 1 / x )') }
end
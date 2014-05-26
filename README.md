# Dydx
It always happens you want to differentiate some formulas with ruby. right?.....

After `inlcude Dydx` , ruby become like other language.

## Dydx is new math DSL in Ruby

I'm going to add for more explanation.



```ruby:
require 'dydx'
include Dydx

f(x) <= x ^ 2

f(3)
# => 9

f(x).to_s
# => "( x ^ 2 )"

f(x) == eval('f(x).to_s')
# => true

g(x) <= d/dx(f(x))

g(3)
# => 6

# => '2 * x'

S(f(x), dx)[0, 1]
# => 0.3333333333333334

( d/dx(log(x)) ).to_s
# => "( 1 / x )"

( d/dx(cos(x)) ).to_s
# => "( - sin( x ) )"

( d/dx(e ^ x) ).to_s
# => "( e ^ x )"

f(x) <= sin(x)
S(f(x), dx)[0, Math::PI/2]
# => 1.000000000021139

f(x) <= (1.0 / ( ( 2.0 * pi ) ^ 0.5 ) ) * ( e ^ (- (x ^ 2) / 2) )
S(f(x), dx)[-oo, oo]
# => 0.9952054164466917

f(x) <= x ^ 2

f(a + b).to_s
# => "( ( a + b ) ^ 2 )"

g(a, b) <= f(a + b)

g(a, b).to_s
# => "( ( a + b ) ^ 2 )"

g(2, 2)
# => 16

( d/da(g(a, b)) ).to_s
=> "( 2 * ( a + b ) )"
```





```
require 'dydx'
include Dydx

# There are three types of differential interface

( d/dx(x^2) ).to_s
=> "( 2 * x )"

log(z).d(z).to_s
=> "( 1 / z )"

$y = e ^ x
(dy/dx).to_s
=> "( e ^ x )"

```

You may wonder why undefined `x` , `e` and `z` are handleable?

`method_missing` solve this problem by converting undefine variable into internal class object.

Like this.

```
 x + x
=> #<Dydx::Algebra::Formula:0x007fb0a4039fb0 @f=#<Dydx::Algebra::Set::Num:0x007fb0a48169e0 @n=2>, @operator=:*, @g=:x>

e
=> #<Dydx::Algebra::Set::E:0x007fb0a383e9f0>

log(sin(x))
=> #<Dydx::Algebra::Set::Log:0x007fe7cd971528 @f=#<Dydx::Algebra::Set::Sin:0x007fe7cd971550 @x=:x>>
```

And this DSL has strong simplify.

```
((x * y) + (z * x)).to_s
=> "( x * ( y + z ) )"

((x ^ y) / (x ^ z)).to_s
=> "( x ^ ( y - z ) )"

(x + x).to_s
=> "( 2 * x )"
```

I show some differential calculus.

```
# pretermit '#to_s'

d/dz(log(z))
=> "( 1 / z )"

d/dx(x^n)
=> "( n * ( x ^ ( n - 1 ) ) )"

$y = cos(x)
dy/dx
=> "( - sin( x ) )"

$x = a * ( (t ^ 2) / 2 )
dx/dt
=> "( a * t )"

d/dt(dx/dt)
=>"a"

((x ^ 2) * y).d(x)
=> "( ( 2 * x ) * y )"

((x ^ 2) * y).d(x).d(y)
=> "( 2 * x )"

```


(That's wonderful!!!!! ..............)

## Installation

Add this line to your application's Gemfile:

    gem 'dydx'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dydx

## Usage

    include Dydx

## Contributing

1. Fork it ( https://github.com/gogotanaka/dydx/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Test

run `bundle exec rake spec`

```
Finished in 3.23 seconds
309 examples, 0 failures
```

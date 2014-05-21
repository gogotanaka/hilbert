# Dydx
It always happens you want to differentiate some formulas with ruby. right?.....

After `inlcude Dydx` , ruby become like other language.

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
Finished in 0.11282 seconds
231 examples, 0 failures
```

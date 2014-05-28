# Dydx is new MATH Language on Ruby.

### Since you report a bug, I will fix it within 24 hours.

The most important thing in this DSL is

we can handle math in the same sense sense of the math on paper.

ex. limit, trigonometric functions and logarithmic.

## Mathematicians should enjoy math even using PC.
(to say nothing of using paper.)

After `inlcude Dydx` , ruby become like other language.

## Outline
```ruby:
require 'dydx'
include Dydx

# Define the function. syntax is not good enough...
f(x) <= x ^ 2

f(3)
=> 9

f(x).to_s
=> "( x ^ 2 )"

f(x) == eval(f(x).to_s)
=> true

# Differentiate
g(x) <= d/dx(f(x))

g(3)
=> 6

g(x).to_s
=> '2 * x'

# Integrate
S(f(x), dx)[0, 1]
=> 0.3333333333333334
```


#### limit, trigonometric functions and logarithmic.
```ruby:

f(z) <= log(z)
S(f(z), dz)[0,1]
=> -Infinity

( d/dx(log(x)) ).to_s
=> "( 1 / x )"

( d/dx(cos(x)) ).to_s
=> "( - sin( x ) )"

( d/dx(e ^ x) ).to_s
=> "( e ^ x )"

f(x) <= sin(x)
S(f(x), dx)[0, Math::PI/2]
=> 1.000000000021139

# standard normal distribution;
f(x) <= (1.0 / ( ( 2.0 * pi ) ^ 0.5 ) ) * ( e ^ (- (x ^ 2) / 2) )
S(f(x), dx)[-oo, oo]
=> 0.9952054164466917
```

#### it's like a magic...

```ruby:
f(x) <= x ^ 2

f(a + b).to_s
=> "( ( a + b ) ^ 2 )"

#↓it's like a magic!!!
g(a, b) <= f(a + b)

g(a, b).to_s
=> "( ( a + b ) ^ 2 )"

g(2, 2)
=> 16

( d/da(g(a, b)) ).to_s
=> "( 2 * ( a + b ) )"

# simplify
((x * y) + (z * x)).to_s
=> "( x * ( y + z ) )"

((x ^ y) / (x ^ z)).to_s
=> "( x ^ ( y - z ) )"

(x + x).to_s
=> "( 2 * x )"
```


## Documents
I'm going to write now...cominng soon....

### Module, class configuration

```
Dydx
  |- Algebra
  |      |- Set
  |      |   |- Num
  |      |   |- ....
  |      |
  |      |- Operator
  |      |   |- Interface
  |      |   |- ....
  |      |
  |      |- Formula
  |      |- inverse
  |
  |- Function
  |- Delta
  |- Integrand
```

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

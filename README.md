# Dydx
It always happens you want to differentiate with ruby. right?

Dydx will eliminate this. Like this


```
( d/dx(:x ^ 2) ).to_s
=> "( 2 * x )"

# pretermit '#to_s'

d/dx(e ^ :x)
=> "( e ^ x )"

d/dz(log(:z))
=> "( 1 / z )"

d/dx(:x^:n)
=> "( n * ( x ^ ( n - 1 ) ) )"

```

you can do like ``` dy/dx ```, if you use global var.

```
$y = cos(:x)
dy/dx
=> "( - sin( x ) )"

$x = :a * ( (:t ^ 2) / 2 )
dx/dt
=> "( a * t )"

d/dt(dx/dt)
=>"a"

```

you can use method chaining.

```
((:x ^ 2) * :y).d(:x)
=> "( ( 2 * x ) * y )"

((:x ^ 2) * :y).d(:x).d(:y)
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

1. Fork it ( https://github.com/[my-github-username]/dydx/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

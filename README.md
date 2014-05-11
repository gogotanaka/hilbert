# Dydx
It always happens you want to differentiate with ruby. right?

Dydx will eliminate this. Like this

```
( d/dx(e ^ :x) ).to_s
=> "( e ^ x )"

$y = cos(:x)
(dy/dx).to_s
=> "( - sin( x ) )"

# pretermit '.to_s'

d/dx(log(:x))
=> "( 1 / x )"

d/dx(:x^:n)
=> "( n * ( x ^ ( n - 1 ) ) )"


d/dx(:x^2)
=> "( 2 * x )"

```

(That's wonderful!!!!! But, I feel there is no meaning ... )

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

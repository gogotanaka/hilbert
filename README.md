# Dydx
It always happens you want to differentiate with ruby. right?

Dydx will eliminate the trouble.

```
d/dx(e ^ :x)
=> ( e ^ x )

 (:x ^ 2).d(:x)
=> ( 2 * x )

$y = cos(:x)
=> ( - sin( x ) )
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

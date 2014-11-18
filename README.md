# Hilbert

[![Gem Version](https://badge.fury.io/rb/hilbert.svg)](http://badge.fury.io/rb/hilbert) [![Build Status](https://travis-ci.org/gogotanaka/Hilbert.svg?branch=master)](https://travis-ci.org/gogotanaka/Hilbert) [![Coverage Status](https://coveralls.io/repos/gogotanaka/Hilbert/badge.png?branch=master)](https://coveralls.io/r/gogotanaka/Hilbert?branch=master) [![Code Climate](https://codeclimate.com/github/gogotanaka/Hilbert/badges/gpa.svg)](https://codeclimate.com/github/gogotanaka/Hilbert) [![Dependency Status](https://gemnasium.com/gogotanaka/Hilbert.svg)](https://gemnasium.com/gogotanaka/Hilbert)

### Do you know the one best language in this world?

#### I believe mathematics (logic) is absolutely that language.

### How can we deal something as great as mathematics in a discrete world?

#### Hilbert is the answer.

Hilbert lets you have a sense of mathematics using a keyboard, the same as you would with a pen.

```
+---Discrete world---+                    +------Mathematics-------+
|        Ruby        |                    |        axiom           |
|        TeX         |<----  Hilbert ---->|    Uncountable noun    |
|       Python       |                    |  real number topology  |
+--------------------+                    +------------------------+
```

## Demo

The code below is input and output for the Hilbert interpreter. (You can try it with `hilbert -i`.)

### Logic
```coffeescript
P -> Q 
Q -> R
(P -> R)?
=> TRUE

P | Q # P or Q
~P    # not P
Q?    # Q is TRUE?
=> TRUE
```

### Differentiate

```
d/dx(cos(x))
=> ( - sin( x ) )

# You can omit parentheses

d/dx log(x)
=> ( 1 / x )

d/dy xy
=> ( x )

d/dx e^x
=> e ^ x
```

### Integrate

```
S(log(x)dx)[0..1]
=> - oo

S(sin(x)dx)[0..pi]
=> 2.0

S(cos(x)dx)[0..pi]
=> 0.0
```

### Limit

```
lim[x->oo] (1 + 1/x)^x
=> 2.7182682371744895

lim[x->0] 1/x
=> oo
```

### Sigma
```
∑[x=0,10] x
=> 55.0
```

### Matrix

```
(1 2 3; 4 5 6)
=> (1 2 3; 4 5 6)

(1 2 3; 4 5 6) + (1 2 3; 4 5 6)
=> (2 4 6; 8 10 12)

(1 2 3; 4 5 6) * (1 2 3)
=> (14 32)
```

### Function
```
f(x, y) = xy
f(1, 2)
=> 2
```


## How to use

Install the `hilbert` gem.

    $ gem install hilbert

Note to OS X Users: If the above `gem` command does not work with the stock version of Ruby (due to not being able to build a target indicated in the Makefile), then you will need to install a version of Ruby that includes the appropriate header files. Using [homebrew](http://brew.sh/) (`brew install ruby`) will suffice.

## Interpreter

    $ hilbert -i
    Enjoy! ->

## Use as native language

### Compile into R

    $ hilbert -r foo.hr

### Compile into Ruby

    $ hilbert -rb foo.hr

### Compile into Python

    $ hilbert -py foo.hr


## Use as math template within other langs


```rb
class ExampleClass
  def example_method
    #your Ruby codes
    ......

I love mathematics.
  a = (1 3 4)
  # your Hilbert codes
Q.E.D

  end
end
```

    $ hilbert -rb example.rb


```rb
class ExampleClass
  def example_method
    #your Ruby codes
    ......

    a = Vector[1, 3, 4]

  end
end
```

## Contributing

Any PRs or issues are welcome. (Please make them to [the `develop` branch](https://github.com/gogotanaka/Hilbert/tree/develop).)

You can become a committer, even if you only commit once.

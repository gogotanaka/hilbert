# Qlang

Enjoy MATH with Keyboard.

### Differentiate

```
Q:-> d/dx(cos(x))
( - sin( x ) )

Q:-> d/dx(log(x))
( 1 / x )

Q:-> d/dy(y ** 2)                        
( 2 * y )
```


### Integrate

```
Q:-> S(log(x)dx)[0..1]
( - sin( x ) )

Q:-> d/dx(log(x))
( 1 / x )

Q:-> d/dy(y ** 2)                        
( 2 * y )
```


### Matrix

```
Q:->(1 2 3; 4 5 6)
(1 2 3; 4 5 6)

Q:-> (1 2 3; 4 5 6) + (1 2 3; 4 5 6)
(2 4 6; 8 10 12)

Q:-> (1 2 3; 4 5 6) * (1 2 3)
(14 32)
```


## How to use

Install it yourself as:

    $ gem install qlang

### Compiler into R

    $ qlang -c -R foo.q
    
### Compiler into Ruby

    $ qlang -c -Ruby foo.q

### Interpreter

    $ qlang -i


## Contributing

1. Fork it ( https://github.com/[my-github-username]/qlang/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

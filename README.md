purescript-pairs
================

This module defines a datatype `Pair` together with a few useful instances and
helper functions. Note that this is not just `Tuple a a` but rather a list
with exactly two elements. Specifically, the `Functor` instance maps over both
values in contrast to the `Functor` instance for `Tuple a`, which can only map
over the second argument.

Example
-------

``` purescript
> let point1 = 2 ~ 3
> let point2 = 4 ~ 7

> sum point1
5

> (+) <$> point1 <*> point2
(6 ~ 10)

> ("Hello" ~ "foo") <> pure " " <> ("World" ~ "bar")
("Hello World" ~ "foo bar")

> collect (\x → x ~ x*x) (1 .. 5)
([1,2,3,4,5] ~ [1,4,9,16,25])
```

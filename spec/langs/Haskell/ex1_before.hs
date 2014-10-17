module Main where

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ []                 = []
filter' p (x:xs) | p x       = x : filter' p xs
                 | otherwise = filter' p xs


-- pattern match for Algebraic data type
data Node = Leaf Integer | Branch Node Node deriving (Show)

depth :: Node -> Integer
depth node = case node of
  Leaf _     -> 1
  Branch a b -> 1 + max (depth a) (depth b)

sumLeaf :: Node -> Integer
sumLeaf node = case node of
  Leaf x     -> x
  Branch a b -> (sumLeaf a) + (sumLeaf b)

-- Maybe monado

--data Maybee a = Justt a | Nothingg deriving (Show)

--return :: a -> Maybee a
--return a = Maybee a

--(>>=) :: Maybee a -> (a -> Maybee b) -> Maybee b
--Nothingg >>= _  = Nothingg
--Justt a >>=  f = f a

add1 :: Maybe Int -> Maybe Int -> Maybe Int
add1 mx my =
  case mx of
    Nothing -> Nothing
    Just x  -> case my of
                 Nothing -> Nothing
                 Just y  -> Just (x + y)

add2 :: Maybe Int -> Maybe Int -> Maybe Int
add2 mx my =
  mx >>= (\x ->
    my >>= (\y ->
      return (x + y)))

add3 :: Maybe Int -> Maybe Int -> Maybe Int
add3 mx my = do
  x <- mx
  y <- my
  return (x + y)


putResult x = putStrLn $ show x


main = do putResult $ filter' (> 2) [1..10]

          let tree = Branch (Leaf 3) (Branch (Leaf 2) (Leaf 4))
          putResult $ depth tree
          putResult $ sumLeaf tree

          putResult $ (Just 1) `add1` Nothing
          putResult $ Nothing `add1` (Just 3)
          putResult $ (Just 1) `add1` (Just 3)
          putResult $ Nothing `add1` Nothing
          putResult $ (Just 1) `add2` Nothing
          putResult $  Nothing `add2` (Just 3)
          putResult $ (Just 1) `add2` (Just 3)
          putResult $ Nothing `add2` Nothing
          putResult $ (Just 1) `add3` Nothing
          putResult $ Nothing `add3` (Just 3)
          putResult $ (Just 1) `add3` (Just 3)
          putResult $ Nothing `add3` Nothing

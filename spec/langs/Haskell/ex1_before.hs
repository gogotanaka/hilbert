module Main where

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ []                 = []
filter' p (x:xs) | p x       = x : filter' p xs
                 | otherwise = filter' p xs

main = do putStrLn $ show $ filter' (> 2) [1..10]

module Golf where

import qualified Data.List as L

skips :: [a] -> [[a]]
skips lst = [each i lst | i <- [1..length lst]]
  where each n l = [lst !! i | i <- [n-1, n-1+n..length lst - 1]]

localMaxima :: [Integer] -> [Integer]
localMaxima (a:b:c:ds)
  | a < b && b > c = b : localMaxima (b:c:ds)
  | otherwise = localMaxima (b:c:ds)
localMaxima _ = []

histogram :: [Integer] -> String
histogram is = (unlines $ map (getLines c) [m + 1, m .. 1])
               ++ "==========\n0123456789\n"
  where c = map (\n -> length $ filter (== n) is) [0..9]
        m = maximum c
        getLines xs n = [if i >= n then '*' else ' ' | i <- xs]

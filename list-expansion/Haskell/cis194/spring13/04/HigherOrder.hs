module HigherOrder where

fun1 :: [Integer] -> Integer
fun1 [] = 1
fun1 (x:xs)
  | even x = (x - 2) * fun1 xs
  | otherwise = fun1 xs

fun2 :: Integer -> Integer
fun2 1 = 0
fun2 n
  | even n = n + fun2 (n `div` 2)
  | otherwise = fun2 (3 * n + 1)

fun1' :: [Integer] -> Integer
fun1' = product . map (subtract 2) . filter even

fun2' :: Integer -> Integer
fun2' = sum
      . filter even
      . takeWhile (/= 1)
      . iterate (\n -> if even n then n `div` 2 else 3 * n + 1)

data Tree a = Leaf
            | Node Integer (Tree a) a (Tree a)
            deriving (Show, Eq)

foldTree :: [a] -> Tree a
foldTree xs = foldr insert Leaf xs
  where
    height Leaf = -1
    height (Node h _ _ _) = h

    insert v Leaf = Node 0 Leaf v Leaf
    insert v (Node _ left nv right)
      | hLeft <= hRight = let newL = insert v left
                          in Node ((+1) . max hRight $ height newL)
                             newL nv right
      | otherwise = let newR = insert v right
                    in Node ((+1) . max hLeft $ height newR)
                       left nv newR
      where hLeft = height left
            hRight = height right

xor :: [Bool] -> Bool
xor = foldr x False
  where x a b
          | a == b = False
          | otherwise = True

map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\x xs -> f x : xs) [] 

sieveSundaram :: Integer -> [Integer]
sieveSundaram n = 2 : [2 * x + 1
                      | x <- [1..n],
                        not
                        (x `elem`
                         [i+j+2*i*j
                         | i <- [1..n],
                           j <- [i..n],
                           i*j+2*i*j <= n])]

{-# OPTIONS_GHC -Wall #-}
module DataStructures where

data BTree a = L
             | N (BTree a) a (BTree a)
             deriving (Show)

sumTree :: (Num a) => BTree a -> a
sumTree (N L v L) = v
sumTree (N left v right) = v + sumTree left + sumTree right
sumTree _ = 0

intTree :: BTree Int
intTree = (N (N L 2 L) 1 (N L 3 L))

unbalancedTree :: BTree Int
unbalancedTree = (N (N
                        (N L 1 (N L 2 L))
                        3
                        L)
                  4
                  L)

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

{-# LANGUAGE EmptyCase #-}
{-# LANGUAGE FlexibleInstances #-}
module Parametricity where

f1 :: a -> a
f1 x = x

f2 :: a -> b
f2 = const undefined

f2' :: a -> b
f2' = (\x -> case x of {})

f3 :: a -> b -> a
f3 x _ = x

f4 :: [a] -> [a]
f4 x = x

f5 :: (b -> c) -> (a -> b) -> (a -> c)
f5 f g = (\x -> f $ g x)

f6 :: (a -> a) -> a -> a
f6 f x = f x

data Foo = F Int | G Char deriving (Show)

instance Eq Foo where
  (F i1) == (F i2) = i1 == i2
  (G c1) == (G c2) = c1 == c2
  _ == _ = False

  foo1 /= foo2 = not (foo1 == foo2)

data Foo' = F' Int | G' Char
          deriving (Eq, Ord, Show)

-- type class
class Listable a where
  toList :: a -> [Int]

instance Listable Int where
  toList x = [x]

instance Listable Bool where
  toList True = [1]
  toList False = [0]

instance Listable [Int] where
  toList = id

data Tree a = Empty
            | Node a (Tree a) (Tree a)

instance Listable (Tree Int) where
  toList Empty = []
  toList (Node val left right) = toList left ++ [val] ++ toList right

sumL :: (Listable a) => a -> Int
sumL x = sum (toList x)

foo :: (Listable a, Ord a) => a -> a -> Bool
foo x y = sum (toList x) == sum (toList y) || x < y

instance (Listable a, Listable b) => Listable (a, b) where
  toList (x, y) = toList x ++ toList y

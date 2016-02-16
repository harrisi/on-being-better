module JoinList where

import Data.Monoid
import Sized
import Scrabble

data JoinList m a = Empty
                  | Single m a
                  | Append m (JoinList m a) (JoinList m a)
                  deriving (Eq, Show)

(+++) :: Monoid m => JoinList m a -> JoinList m a -> JoinList m a
Empty +++ a = a
a +++ Empty = a
a +++ b = Append ((tag a) <> (tag b)) a b
  where tag Empty = mempty
        tag (Single m _) = m
        tag (Append m _ _) = m

indexJ :: (Sized b, Monoid b) =>
          Int -> JoinList b a -> Maybe a
indexJ i _ | i < 0 = Nothing
indexJ _ Empty = Nothing
indexJ i jl@(Single m a)
  | i == (jlSize jl - 1) = Just a
  | otherwise = Nothing
indexJ i jl@(Append m l r)
  | i >= jlSize jl = Nothing
  | i < lSize = indexJ i l
  | otherwise = indexJ (i - lSize) r
  where lSize = jlSize l

jlSize :: (Sized m) => JoinList m a -> Int
jlSize Empty = 0
jlSize (Single m _) = getSize $ size m
jlSize (Append m _ _) = getSize $ size m

(!!?) :: [a] -> Int -> Maybe a
[] !!? _ = Nothing
_ !!? i | i < 0 = Nothing
(x:xs) !!? 0 = Just x
(x:xs) !!? i = xs !!? (i - 1)

jlToList :: JoinList m a -> [a]
jlToList Empty = []
jlToList (Single _ a) = [a]
jlToList (Append _ a b) = jlToList a ++ jlToList b

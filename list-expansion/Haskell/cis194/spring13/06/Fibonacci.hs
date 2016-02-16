module Fibonacci where

fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

fibs1 :: [Integer]
fibs1 = map fib [0..]

fibs2 :: [Integer]
fibs2 = let fibs2' a b = a : (fibs2' b $ a + b)
        in fibs2' 0 1

data Stream a = S a (Stream a)

streamToList :: Stream a -> [a]
streamToList (S a s) = a : streamToList s

instance Show a => Show (Stream a) where
  show s = show $ take 20 $ streamToList s

streamRepeat :: a -> Stream a
streamRepeat v = S v (streamRepeat v)

streamMap :: (a -> b) -> Stream a -> Stream b
streamMap f (S a b) = (S (f a)) $ streamMap f b

streamFromSeed :: (a -> a) -> a -> Stream a
streamFromSeed f a = S a $ streamFromSeed f $ f a

nats :: Stream Integer
nats = streamFromSeed (+1) 0

ruler :: Stream Integer
ruler = startRuler 0
  where startRuler i = interleaveStreams (streamRepeat i) (startRuler (i+1))
          where interleaveStreams (S x ys) zs = S x (interleaveStreams zs ys)

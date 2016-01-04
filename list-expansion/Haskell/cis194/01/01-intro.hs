import qualified Data.List as DL

i :: Int
i = -78

biggestInt, smallestInt:: Int
biggestInt = maxBound
smallestInt = minBound

n :: Integer
n = 12345678987654321987340982334987349872349874534

reallyBig :: Integer
reallyBig = 2^(2^(2^(2^2)))

numDigits :: Int
numDigits = length $ show reallyBig

numDigits' :: (Num a, Show a) => a -> Integer
numDigits' = DL.genericLength . show

d1, d2 :: Double
d1 = 4.5387
d2 = 6.2831e-4

b1, b2 :: Bool
b1 = True
b2 = False

c1, c2, c3 :: Char
c1 = 'x'
c2 = 'Ø'
c3 = 'ダ'

s :: String
s = "Hello, Haskell!"

ex01 = 3 + 2
ex02 = 19 - 27
ex03 = 2.35 * 8.6
ex04 = 8.7 / 3.1
ex05 = mod 19 3
ex06 = 19 `mod` 3
ex07 = 7 ^ 222
ex08 = (-3) * (-7)

-- badArith1 = i + n

-- badArith2 = i / i

ex09 = i `div` i
ex10 = 12 `div` 5

ex11 = True && False
ex12 = not (False || True)

ex13 = ('a' == 'a')
ex14 = (16 /= 3)
ex15 = (5 > 3) && ('p' <= 'q')
ex16 = "Haskell" > "C++"

-- Compute the sum of the integers from 1 to n.
sumtorial :: Integer -> Integer
sumtorial 0 = 0
sumtorial n = n + sumtorial (n - 1)

hailstone :: Integer -> Integer
hailstone n
  | n `mod` 2 == 0 = n `div` 2
  | otherwise = 3 * n + 1

foo :: Integer -> Integer
foo 0 = 16
foo 1
  | "Haskell" > "C++" = 3
  | otherwise = 4
foo n
  | n < 0 = 0
  | n `mod` 17 == 2 = -43
  | otherwise = n + 3

-- Too complicated.
{--
isEven :: Integer -> Bool
isEven n
  | n `mod` 2 == 0 = True
  | otherwise = False
--}

-- Better.
isEven :: Integer -> Bool
isEven n = (n `mod` 2) == 0

p :: (Int, Char)
p = (3, 'x')

sumPair :: (Int, Int) -> Int
sumPair (x, y) = x + y

f :: Int -> Int -> Int -> Int
f x y z = x + y + z

ex17 = f 3 17 8

nums, range, range2 :: [Integer]
nums = [1,2,3,19]
range = [1..100]
range2 = [2,4..100]

hello1 :: [Char]
hello1 = ['h', 'e', 'l', 'l', 'o']

hello2 :: String
hello2 = "hello"

helloSame = hello1 == hello2

emptyList = []

ex18 = 1 : []
ex19 = 3 : (1 : [])
ex20 = 2 : 3 : 4 : []

ex21 = [2, 3, 4] == 2 : 3 : 4 : []

hailstoneSeq :: Integer -> [Integer]
hailstoneSeq 1 = [1]
hailstoneSeq n = n : hailstoneSeq (hailstone n)

intListLength :: [Integer] -> Integer
intListLength [] = 0
intListLength (x:xs) = 1 + intListLength xs

sumEveryTwo :: [Integer] -> [Integer]
sumEveryTwo [] = []
sumEveryTwo (x:[]) = [x]
sumEveryTwo (x:y:zs) = (x + y) : sumEveryTwo zs

-- The number of hailstone steps needed to reach 1 from a
-- starting number.
hailstoneLen :: Integer -> Integer
hailstoneLen n = intListLength (hailstoneSeq n) - 1

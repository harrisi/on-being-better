module HW01 where

-- Exercise 1
toDigits :: Integer -> [Integer]
toDigits n
  | n > 0 = splitDigits n
  | otherwise = []
  where splitDigits 0 = []
        splitDigits x = splitDigits (x `div` 10) ++ [x `mod` 10]

toDigitsRev :: Integer -> [Integer]
toDigitsRev n
  | n > 0 = splitDigitsRev n
  | otherwise = []
  where splitDigitsRev 0 = []
        splitDigitsRev x = x `mod` 10 : splitDigitsRev (x `div` 10)

-- Exercise 2
doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther = reverse . zipWith id (cycle [id, (* 2)]) . reverse

-- Exercise 3
sumDigits :: [Integer] -> Integer
sumDigits = sum . concat . map toDigits

-- Exercise 4
validate :: Integer -> Bool
validate = (== 0) . (`mod` 10) . sumDigits . doubleEveryOther . toDigits

-- Exercise 5
type Peg = String
type Move = (Peg, Peg)
hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi 0 _ _ _ = []
hanoi n a b c = hanoi (n - 1) a c b ++ [(a, b)] ++ hanoi (n - 1) c b a

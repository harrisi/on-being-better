strLength :: String -> Int
strLength [] = 0
strLength (_:xs) = let len_rest = strLength xs in
                   len_rest + 1

frob :: String -> Char
frob [] = 'a' -- len is not in scope here
from str
  | len > 5 = 'x'
  | len < 3 = 'y'
  | otherwise = 'z'
  where
    len = strLength str

sumTo20 :: [Int] -> Int
sumTo20 nums = go 0 nums -- accumulator is 0
  where go :: Int -> [Int] -> Int
        go acc [] = acc
        go acc (x:xs)
          | acc >= 20 = acc
          | otherwise = go (acc + x) xs

doStuff1 :: [Int] -> Int
doStuff1 [] = 0
doStuff1 [_] = 0
doStuff1 xs = head xs + (head (tail xs))

doStuff2 :: [Int] -> Int
doStuff2 [] = 0
doStuff2 [_] = 0
doStuff2 (x1:x2:_) = x1 + x2

{--
The below three definitions can instead simply be calls to `map`.

exampleList :: [Int]
exampleList = [-1, 2, 6]

map (+ 1) exampleList
map abs exampleList
map (^ 2) exampleList
--}

addOneToAll :: [Int] -> [Int]
addOneToAll [] = []
addOneToAll (x:xs) = x + 1 : addOneToAll xs

absAll :: [Int] -> [Int]
absAll [] = []
absAll (x:xs) = abs x : absAll xs

squareAll :: [Int] -> [Int]
squareAll [] = []
squareAll (x:xs) = x ^ 2 : squareAll xs

{--
Following two definitions can be replaced with calls to `filter`.

exampleList :: [Int]
exampleList = [-1, 4, 3, -2, 0]

filter (> 0) exampleList
filter even exampleList
--}

keepOnlyPositive :: [Int] -> [Int]
keepOnlyPositive [] = []
keepOnlyPositive (x:xs)
  | x > 0 = x : keepOnlyPositive xs
  | otherwise = keepOnlyPositive xs

keepOnlyEven :: [Int] -> [Int]
keepOnlyEven [] = []
keepOnlyEven (x:xs)
  | even x = x : keepOnlyEven xs
  | otherwise = keepOnlyEven xs

{--
Following three definitions can be replaced with calls to `fold`.

exampleList :: [Int]
exampleList [1, 2, 4, 5, 9, 3]

foldr (+) 0 exampleList
foldr (*) 1 exampleList
foldr (\_ s -> 1 + s) 0
--}

sum' :: [Int] -> Int
sum' [] = 0
sum' (x:xs) = x + sum' xs

product' :: [Int] -> Int
product' [] = 1
product' (x:xs) = x * product' xs

length' :: [a] -> Int
length' [] = 0
length' (_:xs) = 1 + length' xs

add1Mul4 :: [Int] -> [Int]
add1Mul4 = map ((* 4) . (+ 1))

negateNumEvens :: [Int] -> Int
negateNumEvens x = negate (length (filter even x))

negateNumEvens' :: [Int] -> Int
negateNumEvens' = negate . length . filter even

negateNumEvens'' :: [Int] -> Int
negateNumEvens'' x = negate $ length $ filter even x

duplicate :: [String] -> [String]
duplicate = map dup
  where dup x = x ++ x

duplicate' :: [String] -> [String]
duplicate' = map (\x -> x ++ x)

f :: Int -> Int -> Int
f x y = 2 * x + y

f' :: Int -> (Int -> Int)
f' x y = 2 * x + y

f'' :: (Int, Int) -> Int
f'' (x, y) = 2 * x + y

schonfinkel :: ((a, b) -> c) -> a -> b -> c
schonfinkel f x y = f (x, y)

unschonfinkel :: (a -> b -> c) -> (a, b) -> c
unschonfinkel f (x, y) = f x y

foobar :: [Integer] -> Integer
foobar [] = 0
foobar (x:xs)
  | x > 3 = (7 * x + 2) + foobar xs
  | otherwise = foobar xs

foobar' :: [Integer] -> Integer
foobar' = sum . map ((+ 2) . (* 7)) . filter (> 3)

-- Following two definitions are equal to map

mumble = (`foldr` []) . ((:) . )

grumble = zipWith ($) . repeat

module HW01 where

import Data.Char (digitToInt)

lastDigit :: Integer -> Integer
lastDigit = toInteger . digitToInt . last . show
{--
For future me:
I have data such as 12345
I want to get the last element of the data
There does exist a function `last` which gives the last element of
a list (although `last` is a partial function, so a better solution
does exist. I am not overly concerned with this, however)
Ergo, I want to get 12345 to be shoved into a list structure
Knowing that a string "foo" is ['f', 'o', 'o'], `last "foo"` is 'o'
Calling `show` on 12345 gives "12345" which is close to what I want
I then call `last` on "12345" which gives '5'
Now I want it back to an Integer. I have at least two options here
The option I'm using above is to convert the char to an Int, and then
convert the Int to an Integer (The assignment requires the type of
`lastDigit` to be Integer -> Integer)
Alternatively (ideally) I would just call `read` after `last` which
would make a nice function of `read . last . show`
However, I cannot call `read` on '5' because '5' is a Char, not
a [Char] (which is a String)
I could use `repeat` which has type a -> [a], and simply returns an
infinite list of the same value repeated
But then I would need to just get the first element (using `take 1`)
and then `read` that
This would leave me with the following definition of `lastDigit'`
I think I prefer the above version, although the below definition
is more general.
--}

lastDigit' :: Integer -> Integer
lastDigit' = read . take 1 . repeat . last . show

dropLastDigit :: Integer -> Integer
dropLastDigit n
  | n < 10 = 0
  | otherwise = toInteger . read . init $ show n

toRevDigits :: Integer -> [Integer]
toRevDigits n
  | n <= 0 = []
  | otherwise = map (toInteger . Data.Char.digitToInt) . reverse $ show n

-- This solution works, but the three different patten matches as well
-- as the explicit recursion isn't ideal. It's much more terse, but,
-- in my opinion, much more beautiful, to write it in the way it is
-- written in doubleEveryOther' (or doubleEveryOther'').
doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther [x] = [x]
doubleEveryOther (x:y:ys) = x : (2 * y) : doubleEveryOther ys

doubleEveryOther' :: [Integer] -> [Integer]
doubleEveryOther' = zipWith (*) (cycle [1, 2])

-- This solution can also be abstracted further to be more general to
-- make a function which maps a finite list of functions repeatedly
-- over a potentially infinite list of arbitrary elements.
-- In this case, I prefer the single prime version above because it's
-- perfectly explicitly in what the goal is.
doubleEveryOther'' :: [Integer] -> [Integer]
doubleEveryOther'' = zipWith ($) (cycle [id, (* 2)])

-- Out of interest of learning, here is a general and specific form
-- of mapping cyclic functions.
mapCyclic :: [a -> b] -> [a] -> [b]
mapCyclic fs = zipWith ($) (cycle fs)

-- Point-free
mapCyclic' :: [a -> b] -> [a] -> [b]
mapCyclic' = zipWith id . cycle

-- Specific implementation of mapCyclic
doubleCyclic :: [Integer] -> [Integer]
doubleCyclic = mapCyclic [id, (* 2)]

-- Specific implementation of mapCyclic'
doubleCyclic' :: [Integer] -> [Integer]
doubleCyclic' = mapCyclic' [id, (* 2)]

doubleEOListComp :: [Integer] -> [Integer]
doubleEOListComp l =
  [f x | (x, f) <- zip l $ cycle [id, (* 2)]]

-- This version of doubleEOListComp avoids constructing and
-- destructing a tuple, but requires ParallelListComp
{--
doubleEOListComp' :: [Integer] -> [Integer]
doubleEOListComp' l =
  [f x | x <- l | f <- cycle [id, (* 2)]]
--}
-- [id x.0, (* 2) x.1, id x.2, (* 2) x.3, ...]

sumDigits :: [Integer] -> Integer
sumDigits = sum . map (toInteger . digitToInt) . concat . map show
{--
FFM:
I have a piece of data that looks like [10, 5, 18, 4]
Essentially I want to manipulate that into data that looks like
[1, 0, 5, 1, 8, 4]
Per item (mapping), I am first `show`ing the element (10 becomes "10")
Then, I map `Data.Char.digitToInt` across each element ("10", or
['1', '0']) becomes [1, 0]
This is repeated for every element in the list, leaving data such as
[[1, 0], [5], [1, 8], [4]]
To flatten this out, I call concat (leaving me with data looking like [1, 0, 5, 1, 8, 4]
I have now massaged the data to look how I wanted in the beginning,
and am now able to call sum (type: (Num a) => [a] -> a)
With this, I now have the result of 19, in this case.
--}

{--
Out of interest of not losing information:
The above is slightly incorrect
I got to that point by messing around in ghci
Unfortunately I didn't look at the types of anything important
It should be obvious by calling `digitToInt` that the type is Int
I missed this. To solve this I simply rearranged the code some and
added a call to `toInteger` with `digitToInt`
I think the above is still a useful piece of information, so I will
keep it how it is.
--}

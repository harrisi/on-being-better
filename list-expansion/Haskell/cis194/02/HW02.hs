{-# OPTIONS_GHC -Wall #-}
module HW02 where

-- Mastermind -----------------------------------------

-- A peg can be one of six colors
data Peg = Red | Green | Blue | Yellow | Orange | Purple
         deriving (Show, Eq, Ord, Enum, Bounded)

-- A code is defined to simply be a list of Pegs
type Code = [Peg]

-- A move is constructed using a Code and two integers; the number of
-- exact matches and the number of regular matches
data Move = Move Code Int Int
          deriving (Show, Eq)

-- List containing all of the different Pegs
colors :: [Peg]
colors = [Red, Green, Blue, Yellow, Orange, Purple]

-- Exercise 1 -----------------------------------------

-- Get the number of exact matches between the actual code and the guess
exactMatches :: Code -> Code -> Int
exactMatches a = length . filter (== True) . map (uncurry (==)) . zip a

{--
FFM:
First I `zip` a with the second implicit parameter
Next I `map` the function `uncurry (==)` on each element - this
creates a slice (terminology?) which is a function which takes two
elements and uses the binary infix operator (==) to compare them,
and, if they're equal, returns True
After that I `filter` the list to only include elements which are True
Finally I get the length of the list, which is the final result.
--}

{--
In writing the above implementation's comment, I realized that I could
shorten it by filtering on `(uncurry (==))`, since that is a
predicate and there is no need to map and then filter
I like this approach much more, and think it is much more elegant as
well as easier to understand.
--}

exactMatches' :: Code -> Code -> Int
exactMatches' a = length . filter (uncurry (==)) . zip a

-- Exercise 2 -----------------------------------------

-- For each peg in xs, count how many times is occurs in ys
countColors :: Code -> [Int]
countColors a = let reds = exactMatches' a (repeat Red)
                    greens = exactMatches' a (repeat Green)
                    blues = exactMatches' a (repeat Blue)
                    yellows = exactMatches' a (repeat Yellow)
                    oranges = exactMatches' a (repeat Orange)
                    purples = exactMatches' a (repeat Purple)
                in
                  [reds, greens, blues, yellows, oranges, purples]

{--
FFM:
This is a very straightforward first attempt
First I create local variables with the let binding for each of the
six colors
Then I compare `a` to a list which is just each color as a repeating
element in an infinite list
Finally I simply manually build a list of each comparison.
--}

{--
While writing the above definition, it became immediately obvious
that it was a reasonable solution, but was extremely repetitive
I wanted to abstract out the `exactMatches' a (repeat Peg)`, and I
am able to do so using `zipWith`
The above definition couldn't be directly translated to the below
definition because originally Peg did not derive the Enum typeclass
Adding that deriving statement to the definition of Peg allows me to
very nicely and cleanly zip `exactMatches'` to a cycle of `[c]`,
which is the input Code, and a list which contains an infinite list
for every value of type Peg
Although it's not important or useful now, this also means one could
add more constructors to Peg and/or change the order, and
`countColors'` would still have meaninful output.
--}
countColors' :: Code -> [Int]
countColors' c = zipWith exactMatches'
                 (cycle [c]) $
                 map repeat [minBound ..]

-- Count number of matches between the actual code and the guess
matches :: Code -> Code -> Int
matches = undefined

-- Exercise 3 -----------------------------------------

-- Construct a Move from a guess given the actual code
getMove :: Code -> Code -> Move
getMove = undefined

-- Exercise 4 -----------------------------------------

isConsistent :: Move -> Code -> Bool
isConsistent = undefined

-- Exercise 5 -----------------------------------------

filterCodes :: Move -> [Code] -> [Code]
filterCodes = undefined

-- Exercise 6 -----------------------------------------

allCodes :: Int -> [Code]
allCodes = undefined

-- Exercise 7 -----------------------------------------

solve :: Code -> [Move]
solve = undefined

-- Bonus ----------------------------------------------

fiveGuess :: Code -> [Move]
fiveGuess = undefined

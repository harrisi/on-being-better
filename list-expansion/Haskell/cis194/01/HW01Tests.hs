-- CIS 194, Spring 2015
--
-- Test cases for HW 01

module HW01Tests where

import HW01
import Testing

-- Exercise 1 -----------------------------------------

testLastDigit :: (Integer, Integer) -> Bool
testLastDigit (n, d) = lastDigit n == d

testDropLastDigit :: (Integer, Integer) -> Bool
testDropLastDigit (n, d) = dropLastDigit n == d

ex1Tests :: [Test]
ex1Tests = [ Test "lastDigit test" testLastDigit
             [(123, 3), (1234, 4), (5, 5), (10, 0), (0, 0)]
           , Test "dropLastDigit test" testDropLastDigit
             [(123, 12), (1234, 123), (5, 0), (10, 1), (0,0)]
           ]

-- Exercise 2 -----------------------------------------

testToRevDigits :: (Integer, [Integer]) -> Bool
testToRevDigits (n, d) = toRevDigits n == d

ex2Tests :: [Test]
ex2Tests = [ Test "toRevDigits test" testToRevDigits
             [(1234, [4,3,2,1]), (0, []), (-17, [])]
           ]

-- Exercise 3 -----------------------------------------

testDoubleEveryOther :: ([Integer], [Integer]) -> Bool
testDoubleEveryOther (n, d) = doubleEveryOther n == d

testDoubleEveryOther' :: ([Integer], [Integer]) -> Bool
testDoubleEveryOther' (n, d) = doubleEveryOther' n == d

testDoubleEveryOther'' :: ([Integer], [Integer]) -> Bool
testDoubleEveryOther'' (n, d) = doubleEveryOther'' n == d

testDoubleCyclic :: ([Integer], [Integer]) -> Bool
testDoubleCyclic (n, d) = doubleCyclic n == d

testDoubleCyclic' :: ([Integer], [Integer]) -> Bool
testDoubleCyclic' (n, d) = doubleCyclic' n == d

testDoubleEOListComp :: ([Integer], [Integer]) -> Bool
testDoubleEOListComp (n, d) = doubleEOListComp n == d

ex3Tests :: [Test]
ex3Tests = [ Test "doubleEveryOther test" testDoubleEveryOther
             [([4,9,5,5], [4,18,5,10]), ([0, 0], [0, 0])]
           , Test "doubleEveryOther' test" testDoubleEveryOther'
             [([4,9,5,5], [4,18,5,10]), ([0, 0], [0, 0])]
           , Test "doubleEveryOther'' test" testDoubleEveryOther''
             [([4,9,5,5], [4,18,5,10]), ([0, 0], [0, 0])]
           -- Out of interest, the following are more of the same.
           , Test "doubleCyclic test" testDoubleCyclic
             [([4,9,5,5], [4,18,5,10]), ([0, 0], [0, 0])]
           , Test "doubleCyclic' test" testDoubleCyclic'
             [([4,9,5,5], [4,18,5,10]), ([0, 0], [0, 0])]
           , Test "doubleEOListComp test" testDoubleEOListComp
             [([4,9,5,5], [4,18,5,10]), ([0, 0], [0, 0])]
           ]

-- Exercise 4 -----------------------------------------

ex4Tests :: [Test]
ex4Tests = [Test "undefined ex4 test" (\_ -> False) [0]]

-- Exercise 5 -----------------------------------------

ex5Tests :: [Test]
ex5Tests = [Test "undefined ex5 test" (\_ -> False) [0]]

-- Exercise 6 -----------------------------------------

ex6Tests :: [Test]
ex6Tests = [Test "undefined ex6 test" (\_ -> False) [0]]

-- All Tests ------------------------------------------

allTests :: [Test]
allTests = concat [ ex1Tests
                  , ex2Tests
                  , ex3Tests
                  , ex4Tests
                  , ex5Tests
                  , ex6Tests
                  ]

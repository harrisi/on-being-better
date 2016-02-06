{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
module Calc where

import ExprT
import Parser
import qualified StackVM as VM

eval :: ExprT -> Integer
eval (Lit n) = n
eval (Add n m) = eval n + eval m
eval (Mul n m) = eval n * eval m

evalStr :: String -> Maybe Integer
evalStr = pEval . parseExp Lit Add Mul
  where pEval Nothing = Nothing
        pEval (Just x) = Just (eval x)

class Expr t where
  lit :: Integer -> t
  add :: t -> t -> t
  mul :: t -> t -> t

instance Expr ExprT where
  lit n = Lit n
  add n m = Add n m
  mul n m = Mul n m

reify :: ExprT -> ExprT
reify = id

instance Expr Integer where
  lit n = n
  add n m = n + m
  mul n m = n * m

instance Expr Bool where
  lit n
    | n > 0 = True
    | otherwise = False
  add n m = n || m
  mul n m = n && m

newtype MinMax = MinMax Integer deriving (Eq, Show)
newtype Mod7 = Mod7 Integer deriving (Eq, Show)

instance Expr MinMax where
  lit = MinMax
  add (MinMax n) (MinMax m) = lit $ max n m
  mul (MinMax n) (MinMax m) = lit $ min n m

instance Expr Mod7 where
  lit = Mod7 . (`mod` 7)
  add (Mod7 n) (Mod7 m) = lit $ (n + m) `mod` 7
  mul (Mod7 n) (Mod7 m) = lit $ (n * m) `mod` 7

testExp :: Expr a => Maybe a
testExp = parseExp lit add mul "(3 * -4) + 5"

testInteger :: Maybe Integer
testInteger = testExp

testBool :: Maybe Bool
testBool = testExp

testMM :: Maybe MinMax
testMM = testExp

testSat :: Maybe Mod7
testSat = testExp

instance Expr VM.Program where
  lit n = [VM.PushI n]
  add n m = n ++ m ++ [VM.Add]
  mul n m = n ++ m ++ [VM.Mul]

compile :: String -> Maybe VM.Program
compile = parseExp lit add mul


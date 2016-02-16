{-# OPTIONS_GHC -Wall #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module Party where

import Employee
import Data.Monoid
import Data.Tree

glCons :: Employee -> GuestList -> GuestList
glCons e (GL employees fun') = GL (e : employees) (empFun e + fun')

instance Monoid GuestList where
  mempty = GL [] 0
  (GL employees fun) `mappend` (GL employees' fun')
    = GL (employees ++ employees') (fun + fun')

moreFun :: GuestList -> GuestList -> GuestList
moreFun gl@(GL _ f) gl'@(GL _ f')
  | f > f' = gl
  | otherwise = gl'

treeFold :: (a -> [b] -> b) -> Tree a -> b
treeFold f t = f (rootLabel t) (map (treeFold f) $ subForest t)

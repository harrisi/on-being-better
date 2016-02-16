{-# OPTIONS_GHC -Wall #-}
-- {-# LANGUAGE DatatypeContexts #-}
module ApplicativeFunctors where

-- import Prelude hiding (Maybe)
-- import Data.Maybe hiding (Maybe)
import Control.Applicative

type Name = String

data Employee = Employee
                { name :: Name
                , phone :: String }
              deriving (Show)

-- data Maybe a = Nothing
--              | Just a

-- instance Applicative Maybe where
--   pure = Just
--   Nothing <*> _ = Nothing
--   _ <*> Nothing = Nothing
--   Just f <*> Just x = Just (f x)

mName, mName' :: Maybe Name
mName = Nothing
mName' = Just "Brent"

mPhone, mPhone' :: Maybe String
mPhone = Nothing
mPhone' = Just "555-1234"

ex01, ex02, ex03, ex04 :: Maybe Employee
ex01 = Employee <$> mName <*> mPhone
ex02 = Employee <$> mName <*> mPhone'
ex03 = Employee <$> mName' <*> mPhone
ex04 = Employee <$> mName' <*> mPhone'

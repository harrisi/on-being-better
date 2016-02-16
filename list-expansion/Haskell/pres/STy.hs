{-# LANGUAGE GADTs #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -Wall #-}

module STy where

{- data Maybe a = Nothing | Just a -}

data Wrap a = Wrap a deriving Show

data STy ty where
  SInt :: STy Int
  SBool :: STy Bool
  SMaybe :: STy a -> STy (Maybe a)
  -- SWrap :: STy a -> STy (Wrap a)
  -- SList :: STy a -> STy [a]
  -- SUnit :: STy ()
  -- SArrow :: STy a -> STy b -> STy (a -> b)

deriving instance Show (STy ty)

zero :: STy ty -> ty
zero SInt = 0
zero SBool = False
zero (SMaybe _) = Nothing
-- zero (SWrap ty) = Wrap (zero ty)
-- zero (SList _) = []
-- zero SUnit = ()
-- zero (SArrow _ res) = const (zero res)

eqSTy :: STy ty -> STy ty -> Bool
eqSTy SInt SInt = True
eqSTy SBool SBool = True
eqSTy (SMaybe a) (SMaybe b) = a `eqSTy` b

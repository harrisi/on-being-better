{-# LANGUAGE RankNTypes #-}
module Example where

--import Data.Map -- ()

f :: forall a. a -> Maybe a
f = Just

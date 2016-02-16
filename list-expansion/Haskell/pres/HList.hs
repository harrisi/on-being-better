{-# LANGUAGE GADTs, TypeOperators, DataKinds, PolyKinds #-}

module HList where

data HList tys where
  Nil :: HList '[]
  (:>) :: h -> HList t -> HList (h ': t)
infixr 5 :>

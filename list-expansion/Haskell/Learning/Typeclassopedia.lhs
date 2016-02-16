> module Typeclassopedia where
> import Data.Monoid

Section 3.2 Instances

Exercise 1.

> data MyEither e a = MyLeft e | MyRight a
>   deriving (Show, Eq)

> instance Functor (MyEither e) where
>   fmap _ (MyLeft l) = MyLeft l
>   fmap f (MyRight r) = MyRight $ f r

I don't know how to define this like I did above.

> -- instance Functor ((->) e) where
>   -- fmap = (.) 

Exercise 2.

I don't know how to define this either.

> -- instance Functor ((,) e) where
>   -- fmap f (x, y) = (x, f y)

> data Pair a = Pair a a
>   deriving (Show, Eq)

This Functor instance differs from a tuple because the function is applied to both elements of the type constructor instead of only the right hand side.

> instance Functor Pair where
>   fmap f (Pair x y) = Pair (f x) $ f y

Exercise 3.

This doesn't make sense to me. I'm having trouble figuring out a way to show any real values.

> data ITree a = Leaf (Int -> a)
>   | Node [ITree a]

I don't really understand this instance implementation, mainly because of the definition of ITree.

> instance Functor ITree where
>   fmap f (Leaf x) = Leaf $ fmap f x
>   fmap f (Node xs) = Node $ map (fmap f) xs

Exercise 4.

Neither of the two below solutions are actually correct.

The idea behind SomeType is that `a` is a concrete type (Int), which doesn't allow a proper definition of fmap.

> -- data SomeType a = SomeType Int deriving (Show)
> -- instance Functor SomeType where
>   -- fmap f (SomeType v) = SomeType $ f v

This is just trying to trick myself with phantom types.

> -- data SomeOtherType a = SomeOtherType

Again, neither of the two above solutions are correct.

> -- data SomeNonFunctor a = SomeNonFunctor a deriving (Show)
> -- mapSomeNonFunctor :: (Num b) => (a -> b) -> SomeNonFunctor a -> SomeNonFunctor b
> -- mapSomeNonFunctor f (SomeNonFunctor v) = SomeNonFunctor $ f v

I believe the above is the correct answer. The above defintion for map is a problem because I can't write the following:

> -- instance Functor SomeNonFunctor where
>   -- fmap = mapSomeNonFunctor

The above is a problem because `mapSomeNonFunctor` has type `(Num b) => (a -> b) -> SomeNonFunctor a -> SomeNonFunctor b`. That type constraint means it is not defined for all b, which isn't the same as the declaration of fmap.

Exercise 5.

I believe the composition of two Functors is also a Functor:

> ex5 :: (Num b, Enum b) => [Maybe b]
> ex5 = take 5 $ (fmap . fmap) (+1) $ map Just [1..]

Section 3.3 Laws

Exercise 1.

> data SomeLawBreakingFunctor a = SomeLawBreakingFunctor Bool a
>   deriving (Show)
> instance Functor SomeLawBreakingFunctor where
>   fmap f (SomeLawBreakingFunctor _ a) = SomeLawBreakingFunctor True $ f a

> data Blah w a = Blah w a deriving (Show)
> instance (Monoid w) => Functor (Blah w) where
>   fmap f (Blah _ a) = Blah mempty $ f a

> data BlahFoo w a = BlahFoo w a deriving (Show)
> instance (Ord w) => Functor (BlahFoo w) where
>   fmap f (BlahFoo o a) = BlahFoo o $ f a

Exercise 2.

The bogus list type's instance of Functor does not obey either of the Functor laws, as shown below with a simple list type.

> data L a = N | a :. L a deriving (Show, Eq)
>
> infixr 5 :.
> 
> instance Functor L where
>   fmap _ N = N
>   fmap g (x :. xs) = g x :. g x :. fmap g xs
>
> someL :: L Int
> someL = 4 :. 5 :. N
> 
> fmapidL :: Bool
> fmapidL = fmap id someL == id someL
> -- False
> fmapghL = (fmap ((+1) . (*2)) someL) == (fmap (+1) . fmap (*2) $ someL)
> -- False

The above should show that L is an instance of Functor, but it is not a law-abiding Functor instance. N.b. L could absolutely be a legal instance of Functor with a slight change (the obvious one) in the definition of fmap.

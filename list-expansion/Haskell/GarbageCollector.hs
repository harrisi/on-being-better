data ObjectType
  = OInt Int Bool
  | OPair ObjectType ObjectType Bool
  deriving (Show)

instance Monad ObjectType where
  return x = OInt x False
  OInt x b >>= f = f x b
  fail _ = error

type VM = [ObjectType]

newVM :: VM
newVM = []

push :: VM -> ObjectType -> VM
push vm ot = ot : vm

push' :: VM -> Int -> VM
push' vm v = (OInt v False) : vm

makeOInt :: Int -> ObjectType
makeOInt v = (OInt v False)

pop :: VM -> VM
pop (hd:tl) = tl
pop _ = undefined

pushPair :: VM -> VM
pushPair (a:b:tl) = (OPair a b False) : tl
pushPair _ = undefined


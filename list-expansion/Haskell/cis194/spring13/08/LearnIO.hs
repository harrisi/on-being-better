module LearnIO where

type Cake = Integer

c :: Cake
c = 0

newtype Recipe a = Recipe a
                 deriving (Show)

r :: Recipe Cake
r = Recipe c

main :: IO ()
-- main = putStrLn "Hello" >> putStrLn "world!"
main = putStrLn "Please Enter a number: " >>
       (readLn >>= (\n -> putStrLn (show (n + 1))))

data D = C Integer String Char
       deriving (Show)

data D2 = C2 { field1 :: Integer, field2 :: String, field3 :: Char }
        deriving (Show)

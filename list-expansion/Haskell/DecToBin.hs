module DecToBin (decToBin) where

decToBin':: Int -> [Int] -> [Int]
decToBin' n b
  | n `div` 2 == 0 = reverse $ n `mod` 2 : b
  | otherwise = n `mod` 2 : decToBin' (n `div` 2) b

decToBin :: Int -> String
decToBin n = concat . map show . reverse $ decToBin' n []

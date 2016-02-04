{-# OPTIONS_GHC -Wall #-}
module LogAnalysis where

import Log

-- Exercise 1
parseMessage :: String -> LogMessage
parseMessage n = res $ words n
  where res s =
          case s of
          ("I":ts:m) -> LogMessage Info (read ts) (unwords m)
          ("W":ts:m) -> LogMessage Warning (read ts) (unwords m)
          ("E":i:ts:m) -> LogMessage (Error (read i))
                          (read ts) (unwords m)
          _ -> Unknown $ unwords s

parse :: String -> [LogMessage]
parse = map parseMessage . lines

-- Exercise 2
insert :: LogMessage -> MessageTree -> MessageTree
insert lm@(LogMessage _ ts _) (Node mtLeft mtLM@(LogMessage _ mtts _) mtRight)
  | ts > mtts = Node mtLeft mtLM (insert lm mtRight)
  | otherwise = Node (insert lm mtLeft) mtLM mtRight
insert lm@(LogMessage _ _ _) Leaf = Node Leaf lm Leaf
insert _ mt = mt

build :: [LogMessage] -> MessageTree
-- build = foldr insert Leaf
build [] = Leaf
build (lm:lms) = insert lm $ build lms

inOrder :: MessageTree -> [LogMessage]
inOrder Leaf = []
inOrder (Node mtLeft mtLM mtRight) = inOrder (mtLeft) ++ [mtLM] ++ inOrder (mtRight)

whatWentWrong' :: [LogMessage] -> [String]
whatWentWrong' ((LogMessage (Error lvl) _ msg) : lms)
  | lvl > 50 = msg : whatWentWrong' lms
  | otherwise = whatWentWrong' lms
whatWentWrong' ((LogMessage _ _ _) : lms) = whatWentWrong' lms
whatWentWrong' _ = []

whatWentWrong'' :: [LogMessage] -> [LogMessage]
whatWentWrong'' (lm@(LogMessage (Error lvl) _ _) : lms)
  | lvl > 50 = lm : whatWentWrong'' lms
  | otherwise = whatWentWrong'' lms
whatWentWrong'' ((LogMessage _ _ _) : lms) = whatWentWrong'' lms
whatWentWrong'' _ = []

whatWentWrong''' :: [LogMessage] -> [LogMessage]
whatWentWrong''' = inOrder . build

whatWentWrong :: [LogMessage] -> [String]
whatWentWrong = whatWentWrong' . whatWentWrong''' . whatWentWrong''

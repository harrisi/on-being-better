{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Functors where

import Text.HTML.Scalpel
import Text.Regex (mkRegexWithOpts, matchRegex)
import Data.Text (strip)

data Funny f a = Funny a (f a)
               deriving (Show)

funnyThing :: Funny Maybe Int
funnyThing = Funny 5 $ Just 3

-- import Control.Applicative ((<|>))

gateRegex = mkRegexWithOpts "^(A|B|C|D|E)\n+$" True False

main :: IO ()
main = do
  i <- allItems
  let (Just is) = i
  let (strippedIs :: [String]) = map strip is
  mapM_ (putStrLn . show) is

allItems :: IO (Maybe [String])
allItems = scrapeURL "https://www2.portofportland.com/PDX/Flights?Day=Today&TimeFrom=12%3A00+AM&TimeTo=11%3A59+PM&Type=D&FlightNum=&CityFromTo=&Airline=" items
  where
    items :: Scraper String [String]
    items = chroots (("tr" :: String) // ("td" :: String)) item

    item :: Scraper String String
    item = text ("td" :: String)

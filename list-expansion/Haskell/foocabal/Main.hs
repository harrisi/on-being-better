{-# OPTIONS_GHC -Wall #-}

module Main where

import Text.HTML.Scalpel
-- import Control.Applicative ((<|>))

main :: IO ()
main = do
  i <- allItems
  let (Just is) = i
  mapM_ (putStrLn . show) is

allItems :: IO (Maybe [String])
allItems = scrapeURL "https://www2.portofportland.com/PDX/Flights?Day=Today&TimeFrom=12%3A00+AM&TimeTo=11%3A59+PM&Type=D&FlightNum=&CityFromTo=&Airline=" items
  where
    items :: Scraper String [String]
    items = chroots ("tr" // "td") item

    item :: Scraper String String
    item = text "td"

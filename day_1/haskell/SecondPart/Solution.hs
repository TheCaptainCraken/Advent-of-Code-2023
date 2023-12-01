module SecondPart.Solution(solve) where

import Data.List ( isPrefixOf, elemIndex )

solve:: String -> String
solve =  show . sum . map (read . (\x -> [head x, last x]) . parseWordNumbers) . lines -- like sol 1

-- This is NOT pretty at all. I could not think of anything better at the moment.
-- If you have a better idea please make a PR.
parseWordNumbers :: String -> String
parseWordNumbers "" = ""
parseWordNumbers str = case elemIndex True .  map (\(i, e) -> isPrefixOf e str || isPrefixOf i str) $ zip [show i| i <- [0..10]] numbersData of
    Nothing -> parseWordNumbers . goNext $ str
    Just i -> (show i) ++ (parseWordNumbers . goNext $ str)
    where
        goNext str = (parseWordNumbers . drop 1) $ str
        numbersData = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
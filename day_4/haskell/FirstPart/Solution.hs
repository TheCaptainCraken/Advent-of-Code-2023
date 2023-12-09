module FirstPart.Solution(solve) where

import Data.List(intersect)

solve:: String -> String
solve input = show . sumPoints . map countPoints . parseInput $ input

data Game = Game [Int] [Int]

sumPoints::[Maybe Int] -> Int
sumPoints points = foldr predicate 0 points where
    predicate Nothing partial = partial
    predicate (Just x) partial = partial +  2^(x-1)

countPoints :: Game -> Maybe Int
countPoints (Game n1 n2) = let points = length $ intersect n1 n2 in if points == 0 then Nothing else Just points 

parseInput::String -> [Game]
parseInput input = map ((\(x, y) -> Game (parseIntList x) (parseIntList y)) . splitOnPipe . drop 2 . words) . lines $ input

parseInt :: String -> Int
parseInt n = read n

parseIntList::[String] -> [Int]
parseIntList ints = map parseInt ints

splitOnPipe:: [String] -> ([String], [String])
splitOnPipe [] = ([], [])
splitOnPipe ("|":rest) = ([], rest)
splitOnPipe (x:xs) = let (first, second) = splitOnPipe xs in (x:first, second)
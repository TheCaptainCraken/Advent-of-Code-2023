module FirstPart.Solution(solve) where

import Data.List(transpose)

solve:: String -> String
solve input = show . sum . findDistances . parseInput . addSpaces $ lines input

computeDistanceBetweenGalaxies:: (Int, Int) -> (Int, Int) -> Int
computeDistanceBetweenGalaxies (x1, y1) (x2, y2) = abs(x2 - x1) + abs(y2 - y1)

findDistances::[(Int, Int)] -> [Int]
findDistances [] = []
findDistances (g:others) = map (computeDistanceBetweenGalaxies g) others ++ findDistances others

isVoidRow:: String -> Bool
isVoidRow row = [] == filter (=='#') row

addSpace::[String] -> [String]
addSpace [] = []
addSpace (row:rest)
    | isVoidRow row = row:row:addSpace rest
    | otherwise = row:addSpace rest

addSpaces::[String] -> [String]
addSpaces input = transpose . addSpace . transpose . addSpace $ input 

parseInput :: [String] -> [(Int, Int)]
parseInput input = concatMap (\(row, line) -> map (\col -> (row, col)) $ findGalaxiesInRow line) $ zip [0::Int ..] input

findGalaxiesInRow::String -> [Int]
findGalaxiesInRow row = [pos | (character, pos) <- zip row [0..], character == '#']
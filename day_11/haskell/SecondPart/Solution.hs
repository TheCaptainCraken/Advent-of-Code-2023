module SecondPart.Solution(solve) where

import Data.List(transpose)

solve:: String -> String
solve input = let rows = lines input in show . sum . findDistances (voidRows rows) (voidColumns rows) . parseInput $ rows

computeDistanceBetweenGalaxies:: [Int] -> [Int] -> (Int, Int) -> (Int, Int) -> Int
computeDistanceBetweenGalaxies vc vr (x1, y1) (x2, y2) = abs(x2 - x1) + abs(y2 - y1) + addTax x1 x2 + addTax y1 y2 where
  addTax::Int -> Int -> Int
  addTax x1 x2 = foldr (\r s -> if (max x1 x2) > r && (min x1 x2) < r then s + 999999 else s) 0 vc

findDistances:: [Int] -> [Int] -> [(Int, Int)] -> [Int]
findDistances _ _ [] = []
findDistances vr vc (g:others) = map (computeDistanceBetweenGalaxies vr vc g) others ++ (findDistances vr vc others)

isVoidRow:: String -> Bool
isVoidRow row = [] == filter (=='#') row

voidRows::[String] -> [Int]
voidRows rows = map (\(i, _) -> i) . filter (\(i, row) -> isVoidRow row) $ zip [0..] rows 

voidColumns::[String] -> [Int]
voidColumns rows = map (\(i, _) -> i) . filter (\(i, column) -> isVoidRow column) $ zip [0..] (transpose rows)

parseInput :: [String] -> [(Int, Int)]
parseInput input = concatMap (\(row, line) -> map (\col -> (row, col)) $ findGalaxiesInRow line) $ zip [0::Int ..] input

findGalaxiesInRow::String -> [Int]
findGalaxiesInRow row = [pos | (character, pos) <- zip row [0..], character == '#']
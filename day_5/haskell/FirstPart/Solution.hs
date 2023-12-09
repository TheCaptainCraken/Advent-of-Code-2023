module FirstPart.Solution(solve) where

solve:: String -> String
solve input = show . minimum .  getSeeds $ input

getSeeds :: String -> [Int]
getSeeds input = parseIntList . tail . head . map words $ lines input

getSoilToFertilizer input = map ((\str -> parseIntList . words $  str)) $ take 40 . drop 3 . lines $ input

parseIntList:: [String] -> [Int]
parseIntList numbers = map read numbers
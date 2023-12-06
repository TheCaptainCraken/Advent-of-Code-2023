module FirstPart.Solution(solve) where

solve:: String -> String
solve input = show . product . map solveRace $ parseInput input

parseInput:: String -> [(Int, Int)]
parseInput input = (\x -> zip (head x) (last x)) . map (parseInts . tail . words) $ lines input

parseInts:: [String] -> [Int]
parseInts input = map parseInt input

parseInt::String -> Int
parseInt input = read input

solveRace::(Int, Int) -> Int
solveRace (time, best) = sum . map (\t -> if calculateDistance t (time-t) > best then 1 else 0) $ [1..time]


calculateDistance::Int -> Int -> Int
calculateDistance speed time = speed * time
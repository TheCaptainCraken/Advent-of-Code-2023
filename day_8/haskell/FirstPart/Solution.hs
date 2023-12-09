module FirstPart.Solution(solve) where

solve:: String -> String
solve input = "todo"

getDirections::String -> String
getDirections input = head . lines $ input

getNodes :: String -> [String]
getNodes input = drop 2 . lines $ input

searchAndCount::String -> [String] -> Int
searchAndCount directions nodes = searchAndCountHelp (cycle directions) nodes "AAA" 0 where
    searchAndCountHelp::String -> [String] -> String -> Int -> Int
    searchAndCountHelp (dir:rest) nodes currentNode count
        | currentNode == "ZZZ" = count 
        | otherwise = searchAndCountHelp rest nodes (filter (\x -> (head . words $ x) == currentNode) nodes) (count +1)
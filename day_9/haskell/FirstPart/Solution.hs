module FirstPart.Solution(solve) where

solve:: String -> String
solve input = show . sum . map (sumLast . generatePyramid) $ parseInput $ input

parseInput::String -> [[Int]]
parseInput input = map ( parseInts . words ) $ lines input

parseInt::String->Int
parseInt n = read n

parseInts::[String]->[Int]
parseInts numbers = map parseInt numbers

isAllZeros::[Int] -> Bool
isAllZeros [] = True
isAllZeros (n:rest) = n==0 && isAllZeros rest

getDifferences::[Int] -> [Int]
getDifferences numbers = zipWith (-) (tail numbers) numbers

generatePyramid::[Int] -> [[Int]]
generatePyramid values = generatePyramidHelper [values] where
    generatePyramidHelper::[[Int]] -> [[Int]]
    generatePyramidHelper values
        | (isAllZeros . last $ values) == True = values
        | otherwise = generatePyramidHelper  (values ++ [(getDifferences . last $ values)])

sumLast::[[Int]] -> Int
sumLast numbers = foldr (\x y -> (last x) + y) 0 numbers
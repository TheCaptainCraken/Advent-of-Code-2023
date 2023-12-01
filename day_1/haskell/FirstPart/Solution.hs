module FirstPart.Solution(solve) where


solve:: String -> String -- First oneliner of this AOC :)
solve =  show . sum . map (read . (\x -> [head x, last x]) . (filter (`elem` "1234567890"))) . lines
module Main where

import qualified SecondPart.Solution as SecondSolution
import qualified FirstPart.Solution as FirstSolution

main:: IO ()
main = do
    input <- readFile "input.txt" 

    putStrLn "Solution to the first part:"
    putStrLn $ FirstSolution.solve input

    putStrLn "Solution to the second part:"
    putStrLn $ SecondSolution.solve input


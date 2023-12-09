module SecondPart.Solution(solve) where

import Data.Maybe(isJust)

solve:: String -> String
solve input = show . sum . handleGames . parseInput $ input

data Game = Game { red::Int, green::Int, blue::Int }

startingGame = Game 0 0 0

parseInput input = map (words . (filter(`notElem` ",;"))) (lines input)

handleGames::[[String]] -> [Int]
handleGames games = map ( calculateGame . (\x -> handleGame x startingGame) . drop 2) $ games where
    calculateGame (Game red blue green) = red * blue * green

handleGame:: [String] -> Game -> Game
handleGame (v:"red":rest) (Game red green blue) = let new = parseInt v in handleGame rest (Game (if new > red then new else red) green blue)
handleGame (v:"green":rest) (Game red green blue) = let new = parseInt v in handleGame rest (Game red (if new > green then new else green) blue)
handleGame (v:"blue":rest) (Game red green blue) = let new = parseInt v in handleGame rest (Game red green (if new > blue then new else blue))
handleGame [] game = game
-- this is never reached because of guarantees from the problem authors

parseInt :: String -> Int
parseInt n = read n
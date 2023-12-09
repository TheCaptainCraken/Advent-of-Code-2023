module FirstPart.Solution(solve) where

import Data.Maybe(isJust)

solve:: String -> String
solve input = show . sumIds . handleGames . parseInput $ input

data Game = Game { red::Int, green::Int, blue::Int }

sumIds :: [Bool] -> Int
sumIds ids = foldr (\(i, id) sum -> if id then sum+i else sum) 0 $ zip [1..] ids

startingGame = Game 0 0 0

parseInput input = map (words . (filter(`notElem` ",;"))) (lines input)

handleGames::[[String]] -> [Bool]
handleGames games = map (isJust . (\x -> handleGame x (Just startingGame)) . drop 2) $ games where

handleGame:: [String] -> Maybe Game -> Maybe Game
handleGame _ Nothing = Nothing
handleGame (v:"red":rest) (Just (Game red green blue)) = if (parseInt v) > 12 then Nothing else handleGame rest (Just (Game (red + parseInt v) green blue))
handleGame (v:"green":rest) (Just (Game red green blue)) = if (parseInt v) > 13 then Nothing else handleGame rest (Just (Game red (green + parseInt v) blue))
handleGame (v:"blue":rest) (Just (Game red green blue)) = if (parseInt v) > 14 then Nothing else handleGame rest (Just (Game red green (blue + parseInt v)))
handleGame [] game = game
handleGame _ _ = Nothing -- this is never reached because of guarantees from the problem authors

parseInt :: String -> Int
parseInt n = read n
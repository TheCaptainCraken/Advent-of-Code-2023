module SecondPart.Solution where

import Data.List(sort)

solve:: String -> String
solve input = show . totalWinnings . sort . parseInput $ input

data Card = Two | Three | Four | Five | Six | Seven | Eight | Nine | T | Q | K | A | J
    deriving (Eq, Show, Ord, Enum, Bounded)

data Hand = Hand [Card] Int
    deriving (Eq, Show)

data HandType = HIGH_CARD | ONE_PAIR | TWO_PAIR | THREE_OF_A_KIND | FULL_HOUSE | FOUR_OF_A_KIND | FIVE_OF_A_KIND
    deriving (Eq, Show, Ord)

parseInput:: String -> [Hand]
parseInput input = map (\x -> Hand (parseCards . head $ x) (parseInt . last $ x)) . map words $ lines input

parseInt::String -> Int
parseInt x = read x

parseCards :: [Char] -> [Card]
parseCards str = map parseCard str

parseCard :: Char -> Card
parseCard  'A' = A
parseCard 'K' = K
parseCard 'Q' = Q
parseCard 'J' = J
parseCard 'T' = T
parseCard '9' = Nine
parseCard '8' = Eight
parseCard '7' = Seven
parseCard '6' = Six
parseCard '5' = Five
parseCard '4' = Four
parseCard '3' = Three
parseCard '2' = Two


totalWinnings::[Hand] -> Int
totalWinnings hands = foldr (\(i, (Hand _ bid)) sum -> sum + i * bid) 0 $ zip [1..] hands

getHandType:: Hand -> HandType
getHandType (Hand cards _) = findType (map (\e -> length $ filter (e==) cards ) [Two, Three , Four , Five , Six , Seven , Eight , Nine , T, Q , K , A]) where
    findType::[Int] -> HandType
    findType occ
        | elem 5 occ = FIVE_OF_A_KIND
        | elem 4 occ = FOUR_OF_A_KIND
        | elem 3 occ && elem 2 occ = FULL_HOUSE
        | elem 3 occ = THREE_OF_A_KIND
        | ((length . filter (2==)) $ occ) == 2 = TWO_PAIR
        | elem 2 occ = ONE_PAIR
        | otherwise = HIGH_CARD

instance Ord Hand where
    compare hand1 hand2
        | getHandType hand1 > getHandType hand2 = GT
        | getHandType hand1 < getHandType hand2 = LT
        | otherwise = lastResortCompare hand1 hand2


lastResortCompare :: Hand -> Hand -> Ordering
lastResortCompare (Hand hand1 b1) (Hand hand2 b2) = let res = compare hand1 hand2 in if res /= EQ then res else lastResortCompare (Hand (tail hand1) b1) (Hand (tail hand2) b2)
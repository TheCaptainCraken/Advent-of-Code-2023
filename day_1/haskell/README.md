# Day 1 Haskell

I really like today's problem as it was simple but not obvious. I struggled a bit in the second part as I discovered Haskell has no string replacement functions in its standard libraries.

## First Part

The code I wrote is the following:

```haskell
show . sum . map (read . (\x -> [head x, last x]) . (filter (`elem` "1234567890"))) . lines
```

let's explore it. This is a (very long) function. The first thing I did was using the `lines` function to separate each line of the input into its own string. Then I used `map` with 3 predicates:

- `filter (``elem`` "1234567890")` discards any character in the string that is not a digit.
- `\x -> [head x, last x]` takes the first and last element of the string and puts them into a list.
- `read` converts a list of digits into a number. For example `["1", "4"] = 14`.

That means `map` retuns a list of integers. At this point I used `sum` to sum every number in the list and `show` to convert the number into a string ready to be printed.

## Second Part

The main diffrence for the second part is I needed to parse also number written like *one* and *seven*. This made the task much harder for me as I haven't used haskell for parsing yet. My solution replaced the `filter` function used in the last part with this:

```haskell
parseWordNumbers "" = ""
parseWordNumbers str = case elemIndex True .  map (\(i, e) -> isPrefixOf e str || isPrefixOf i str) $ zip [show i| i <- [0..10]] numbersData of
    Nothing -> parseWordNumbers . goNext $ str
    Just i -> (show i) ++ (parseWordNumbers . goNext $ str)
    where
        goNext str = (parseWordNumbers . drop 1) $ str
        numbersData = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
```

I know it's not the prettiest and most efficient piece of code ever but I just started writing haskell so this is my best. The scope of this function is to take a line from the input and transform it into a string of digits. To do that I used recursion. The base case is quite simple: `parseWordNumbers "" = ""` if the input string is empty then there aren't any numbers to parse. Let's unpack the rest:

```haskell
elemIndex True .  map (\(i, e) -> isPrefixOf e str || isPrefixOf i str) $ zip [show i| i <- [0..10]] numbersData
```

This part tries to find if there is a number at the start of the string. For example `onesdfiuu -> 1` or `3seven -> 3`. to do that it zips together an array I buit with the names of each digit in order (this is important) and a list containing the first every digit (`[show i| i <- [0..10]]`). The I mapped this array of tuples with a predicate that uses the `isPrefixOf` function from `Data.List` to find out if a substring is the prefix of another string. The maps produces a list of booleans that will either be all false or have one true element. If there is a true element it means that there is a digit at the start of the string. The index of the true value will tell use wich digit. This is exaclty what happens.

If `elemIndex` does not find a true element in the list from `map` then we just shave off one character from the string a start over. If a digit is found then the index is the digit because of how I defined `numberData` and the list of the digits. This means I can just use `show` to convert the digit to a string and the concatenate this with a recursive call.

## How to Build

To run the solution you need a compiler. I strongly suggest you install [GHCUP](https://www.haskell.org/). After that you can either compile or run the solution interctively. I suggest you do the second. In any case you need to download the input from the website and save it in this folder as `input.txt`. After that just:

```BASH
ghci
:load Main.hs
main
```

And the solutions will be printed in your terminal.

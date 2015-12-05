#!/usr/bin/env runhaskell
module Main where
import Data.List

-- draws from & is inspired by travisby's implementation
-- (https://gist.github.com/travisby/0fa62b22f860afa01a93)

main = do
    contents <- getContents
    let packages = map (strToList) $ lines contents
    print $ total packages

total :: [[Int]] -> Int
total xs = sum $ map single xs

single :: [Int] -> Int
single xs = 2 * (sum ys) + (minimum ys)
    where ys = areas xs

areas :: [Int] -> [Int]
areas xs = map (\(x,y) -> x*y) (zip xs $ rotate xs)

rotate :: [a] -> [a]
rotate xs = drop 1 xs ++ take 1 xs

strToList :: String -> [Int]
strToList str = map read $ split str 'x'

split :: String -> Char -> [String]
split xs c = foldr (splitOne c) [] xs

splitOne :: Char -> Char -> [String] -> [String]
splitOne _ x [] = [[x]]
splitOne a b (x:xs)
    | a == b = []:x:xs
    | otherwise = (b:x):xs

module Main where

import Lib

main :: IO ()
main = do
    (title, link) <- parseRss
    print (title ++ ": " ++ link)
module Main where

import Lib
import System.Environment
import Parser.OptionsParser

main :: IO ()
main = do
    opts <- parseArgs
    print(opts)

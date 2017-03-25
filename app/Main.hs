module Main where

import Lib
import Parser.OptionsParser
import System.Environment
import Type.OptionsParser

main :: IO ()
main = do
  opts <- parseArgs
    --read file
  input <- getInput (filepath opts)
    --parse context free grammar
    --run selected mode
  case mode opts of
    PrintMode -> print input
    SimpleMode -> print "mode SimpleMode not implemented yet"
    CnfMode -> print "mode CnfMode not implemented yet"
        --_ -> print"not supported mode" --redundant

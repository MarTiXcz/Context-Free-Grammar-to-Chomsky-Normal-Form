module Main where

import CFGAlgorithms
import Lib
import Parser.CFGParser
import Parser.OptionsParser
import System.Environment
import System.IO (hPutStrLn, stderr)
import Type.CFGParser
import Type.OptionsParser

main :: IO ()
main = do
  opts <- parseArgs
  --read file
  input <- getInput (filepath opts)
  --parse context free grammar
  case parseCFG input of
    Left e -> do
      hPutStrLn stderr "Error parsing input:"
      print e
    Right r -> runMode (mode opts) r

--run selected mode
runMode :: Mode -> TCFGrammar -> IO ()
runMode mode grammar =
  case mode of
    PrintMode -> printCFG grammar
    SimpleMode -> printCFG (removeSimpleRules grammar)
    CnfMode -> printCFG (convertToCNF grammar)

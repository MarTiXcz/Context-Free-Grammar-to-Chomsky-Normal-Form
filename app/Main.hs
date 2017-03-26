module Main where

import Lib
import Parser.CFGParser
import Parser.OptionsParser
import System.Environment
import Type.OptionsParser
import Type.CFGParser
import CFGAlgorithms

main :: IO ()
main = do
  opts <- parseArgs
    --read file
  input <- getInput (filepath opts)
    --parse context free grammar
  case parseCFG input of
      Left e -> do
        putStrLn "Error parsing input:" 
        print e
      Right r -> runMode (mode opts) r
    --run selected mode

runMode :: Mode -> TCFGrammar -> IO ()
runMode mode grammar=  
     case mode of
        PrintMode -> printCFG grammar
        -- SimpleMode -> printCFG (removeSimpleRules grammar)
        -- SimpleMode -> printRules (createNewRules (tNonTerminals grammar) (tRules grammar))
        SimpleMode -> printCFG (removeSimpleRules grammar)       
        CnfMode -> print "mode CnfMode not implemented yet"

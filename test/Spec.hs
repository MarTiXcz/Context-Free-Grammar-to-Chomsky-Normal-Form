import Lib
import Parser.CFGParser
import Parser.OptionsParser
import System.Environment
import Type.OptionsParser

main :: IO ()
main
    --parse arguments
 = do
  opts <- withArgs ["-i", "resources/test.txt"] parseArgs
    --read file
  input <- getInput (filepath opts)
    --parse context free grammar
--   grammar <- case parseCFG input of
--       Left e -> do
--         putStrLn "Error parsing input:" 
--         print e
--       Right r -> r
    --run selected mode
  case mode opts of
    PrintMode -> print input
    SimpleMode -> print "mode SimpleMode not implemented yet"
    CnfMode -> print "mode CnfMode not implemented yet"

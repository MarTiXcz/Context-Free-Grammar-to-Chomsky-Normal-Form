import Lib
import Parser.CFGParser
import Parser.OptionsParser
import System.Environment
import Type.OptionsParser
import Type.CFGParser

main :: IO ()
main
    --parse arguments
 = do
  opts <- withArgs ["-i", "resources/test.txt"] parseArgs
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
        PrintMode -> print grammar
        SimpleMode -> print "mode SimpleMode not implemented yet"
        CnfMode -> print "mode CnfMode not implemented yet"

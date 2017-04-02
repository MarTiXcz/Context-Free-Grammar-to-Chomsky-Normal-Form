import CFGAlgorithms
import Lib
import Parser.CFGParser
import Parser.OptionsParser
import System.Environment
import Type.CFGParser
import Type.OptionsParser
import System.IO (hPutStrLn, stderr)

main :: IO ()
main
 = do
  --parse arguments
  opts <- withArgs ["-2", "resources/study-text-example.txt"] parseArgs
  -- opts <- withArgs ["-2", "resources/test.txt"] parseArgs
  --opts <- withArgs ["-i", "resources/test.txt"] parseArgs
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

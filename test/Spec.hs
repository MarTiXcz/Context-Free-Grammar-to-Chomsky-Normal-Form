import System.Environment
import Lib
import Parser.OptionsParser
import Type.OptionsParserType


main :: IO ()
main = do
    opts <- withArgs ["-i"] parseArgs
    print(opts)
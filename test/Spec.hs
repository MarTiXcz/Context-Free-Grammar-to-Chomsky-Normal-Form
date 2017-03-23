import System.Environment
import Lib

main :: IO ()
main = withArgs ["-i"] parseArgs

import System.Environment
import Lib

main :: IO ()
main = withArgs ["-2", "-i"] parseArgs

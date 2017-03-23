import System.Environment
import Lib

main :: IO ()
main = withArgs ["--some-flag"] parseArgs

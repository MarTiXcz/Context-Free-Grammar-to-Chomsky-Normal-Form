module Lib where

import Data.Semigroup ((<>))
import Options.Applicative


data Mode = PrintMode | SimpleMode | CnfMode
    deriving Show

data Opts = Opts 
    { mode :: Mode
    , filepath :: FilePath
    }
    deriving Show

version :: String
version = "0.1"


parseArgs :: IO()
parseArgs = do
    mode <- execParser optsParser
    print (mode)
    where
    optsParser =
        info
            (helper <*> versionOption <*> fullParser)
            (fullDesc <> progDesc "BKG-2-CNF" <>
             header
                 "BKG-2-CNF-program for converting any CFG to CNF")
    versionOption = infoOption version (long "version" <> help "Show version")


printMode :: Parser Mode
printMode = flag' PrintMode (short 'i' <> help "Print unchanged CFG")

simpleMode :: Parser Mode
simpleMode = flag' SimpleMode (short '1' <> help "Print CFG without simple rules")

cnfMode :: Parser Mode
cnfMode = flag' CnfMode (short '2' <> help "Print CFG in CNF")

modeParser :: Parser Mode
modeParser = printMode <|> simpleMode <|> cnfMode

fullParser :: Parser Opts
fullParser = Opts <$> modeParser <*> fileInput


fileInput :: Parser FilePath
fileInput = argument str
  ( metavar "FILENAME"
  <> value ""
  <> help "Input file" )

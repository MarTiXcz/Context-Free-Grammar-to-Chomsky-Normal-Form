module Parser.OptionsParser where

import Data.Semigroup ((<>))
import Options.Applicative

import Type.OptionsParserType

version :: String
version = "0.1"

parseArgs :: IO Opts
parseArgs = do
    opts <- execParser optsParser
    return opts
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

fileInput :: Parser FilePath
fileInput = argument str
  ( metavar "Filename"
  <> value ""
  <> help "Input file" )

fullParser :: Parser Opts
fullParser = Opts <$> modeParser <*> fileInput


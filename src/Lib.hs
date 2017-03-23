module Lib where

import Data.Semigroup ((<>))
import Options.Applicative
import Data.Sequence ((<|))

data Opts = Opts
    { optionI :: !Bool
    , option1 :: !Bool
    , option2 :: !Bool
    , optVal :: !String
    }
data Mode = Print | Simple | Cnf


version :: String
version = "0.1"


parseArgs :: IO()
parseArgs = do
    opts <- execParser optsParser
    putStrLn
        (concat ["Hello, ", optVal opts, ", the flag i is ", show (optionI opts),
         ", the flag i is ", show (option1 opts), ", the flag 2 is ", show (option2 opts)])
  where
    optsParser =
        info
            (helper <*> versionOption <*> programOptions)
            (fullDesc <> progDesc "BKG-2-CNF" <>
             header
                 "BKG-2-CNF-program for converting any CFG to CNF")
    versionOption = infoOption version (long "version" <> help "Show version")

programOptions :: Parser Opts
programOptions =
        Opts <$> switch (short 'i' <> help "Print unchanged CFG") <*>
        switch (short '1' <> help "Print CFG without simple rules") <*>
        switch (short '2' <> help "Print CFG in CNF") <*>
        strOption
            (long "some-value" <> metavar "VALUE" <> value "default" <>
             help "Override default name")
module Lib where

import Data.Semigroup ((<>))
import Options.Applicative
import Data.Sequence ((<|))

data Opts = Opts
    { optFlag :: !Bool
    , optVal :: !String
    }

someFunc :: IO ()
someFunc = putStrLn "someFunc"


parseArgs :: IO()
parseArgs = do
    opts <- execParser optsParser
    putStrLn
        (concat ["Hello, ", optVal opts, ", the flag is ", show (optFlag opts)])
  where
    optsParser =
        info
            (helper <*> versionOption <*> programOptions)
            (fullDesc <> progDesc "BKG-2-CNF" <>
             header
                 "BKG-2-CNF-program for converting any CFG to CNF")
    versionOption = infoOption "0.0" (long "version" <> help "Show version")
    programOptions =
        Opts <$> switch (short 'i' <> help "Print unchanged CFG") <*
        switch (short '1' <> help "Print CFG without simple rules") <*
        switch (short '2' <> help "Print CFG in CNF") <*>
        strOption
            (long "some-value" <> metavar "VALUE" <> value "default" <>
             help "Override default name")
module Lib where

import Parser.OptionsParser
import System.Exit (exitFailure)
import System.IO (readFile)
import System.IO.Error
       (catchIOError, ioeGetFileName, isDoesNotExistError)

getInput :: String -> IO String
getInput "" = getContents
getInput filePath = readFile filePath `catchIOError` handler

handler :: IOError -> IO String
handler e
  | isDoesNotExistError e = do
    case ioeGetFileName e of
      Just path -> putStrLn $ "Whoops! File does not exist at: " ++ path
      Nothing -> putStrLn "Whoops! File does not exist at unknown location!"
    exitFailure
  | otherwise = ioError e

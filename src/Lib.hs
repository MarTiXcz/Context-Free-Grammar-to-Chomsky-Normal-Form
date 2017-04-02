module Lib where

import Parser.OptionsParser
import System.Exit (exitFailure)
import System.IO (readFile, hPutStrLn, stderr)
import System.IO.Error
       (catchIOError, ioeGetFileName, isDoesNotExistError)
import Type.CFGParser


getInput :: String -> IO String
getInput "" = getContents
getInput filePath = readFile filePath `catchIOError` handler

handler :: IOError -> IO String
handler e
  | isDoesNotExistError e = do
    case ioeGetFileName e of
      Just path -> hPutStrLn stderr $ "Whoops! File does not exist at: " ++ path
      Nothing -> hPutStrLn stderr "Whoops! File does not exist at unknown location!"
    exitFailure
  | otherwise = ioError e

--print output functions

--private funkce
printStringSepByComma :: [String] -> IO ()
printStringSepByComma [] = return ()
printStringSepByComma [x] = putStr $ x ++ ['\n']
printStringSepByComma (x:xs) = do
  putStr $ x ++ [',']
  printStringSepByComma xs

printTerminalsSepByComma :: String -> IO ()
printTerminalsSepByComma [] = return ()
printTerminalsSepByComma [x] = putStr [x ,'\n']
printTerminalsSepByComma (x:xs) = do
  putStr [x, ',']
  printTerminalsSepByComma xs


printNonTerminals :: [TNonTerminal] -> IO ()
printNonTerminals = printStringSepByComma

printTerminals :: [TTerminal] -> IO ()
printTerminals = printTerminalsSepByComma

printStart :: TNonTerminal -> IO ()
printStart nonTerminal = putStr $ nonTerminal ++ ['\n']

printRule :: TRule -> IO ()
printRule rule = do 
  putStr $ tNonTerminal rule
  putStr "->"
  putStr $ tExpression rule ++ ['\n']

printRules :: [TRule] -> IO ()
printRules [] = return ()
printRules (x:xs) = do
  printRule x
  printRules xs

printCFG :: TCFGrammar -> IO ()
printCFG grammar = do
  printNonTerminals $ tNonTerminals grammar
  printTerminals $ tTerminals grammar
  printStart $ tStartNonTerminal grammar
  printRules $ tRules grammar
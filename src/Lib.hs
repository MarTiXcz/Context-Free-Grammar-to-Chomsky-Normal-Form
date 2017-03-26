module Lib where

import Parser.OptionsParser
import System.Exit (exitFailure)
import System.IO (readFile)
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
      Just path -> putStrLn $ "Whoops! File does not exist at: " ++ path
      Nothing -> putStrLn "Whoops! File does not exist at unknown location!"
    exitFailure
  | otherwise = ioError e

--print output functions
-- printNonTerminals2 :: [TNonTerminal] -> IO ()
-- -- printNonTerminals [] = return ()
-- printNonTerminals2 (x:xs) = do
--   putChar x
--   if null xs
--     then putChar '\n'
--     else do
--     putChar ','
--     printNonTerminals2 xs
--TODO: ODSTRANIT REKURZI
--private funkce
printStringSepByComma :: [TSymbol] -> IO ()
printStringSepByComma [] = return ()
printStringSepByComma [x] = putStr [x, '\n']
printStringSepByComma (x:xs) = do
  putStr [x, ',']
  printStringSepByComma xs

printNonTerminals :: [TNonTerminal] -> IO ()
printNonTerminals = printStringSepByComma

printTerminals :: [TTerminal] -> IO ()
printTerminals = printStringSepByComma

printStart :: TNonTerminal -> IO ()
printStart nonTerminal = putStr [nonTerminal, '\n']

printRule :: TRule -> IO ()
printRule rule = do 
  putChar $ tNonTerminal rule
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
  printStart $ tStartTerminal grammar
  printRules $ tRules grammar
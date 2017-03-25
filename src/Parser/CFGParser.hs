module Parser.CFGParser
  ( parseCFG
  ) where

import Text.ParserCombinators.Parsec
import Type.CFGParser

comma :: Parser Char
comma = char ','

parseNonTerminals :: Parser [TNonTerminal]
parseNonTerminals = sepBy1 upper comma

parseTerminals :: Parser [TTerminal]
parseTerminals = sepBy1 lower comma

arrow :: Parser String
arrow = string "->"

parseRule :: Parser TRule
parseRule = do
  nonTerminal <- upper
  arrow
  expression <- many1 letter
  return $ TRule nonTerminal expression

newLine :: Parser Char
newLine = char '\n'

parseRules :: Parser [TRule]
parseRules =
  many1 $ do
    rule <- parseRule
    newLine
    return rule

cFG :: Parser TCFGrammar
cFG = do
  nonTerminals <- parseNonTerminals
  newLine
  terminals <- parseTerminals
  newLine
  start <- upper
  newLine
  rules <- parseRules
  return $ TCFGrammar nonTerminals terminals start rules

parseCFG :: String -> Either ParseError TCFGrammar
parseCFG = parse cFG ""

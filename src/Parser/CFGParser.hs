module Parser.CFGParser
  ( parseCFG
  ) where

import Text.ParserCombinators.Parsec
import Type.CFGParser

comma :: Parser Char
comma = char ','

parseNonTerminal :: Parser TNonTerminal 
parseNonTerminal = do
  x <- many(upper <*> char '\'') <|> upper 
  --y <- option _ (char '\'')
  return x

parseNonTerminals :: Parser [TNonTerminal]
parseNonTerminals = sepBy1 parseNonTerminal comma

parseTerminals :: Parser [TTerminal]
parseTerminals = sepBy1 lower comma

arrow :: Parser String
arrow = string "->"

parseRule :: Parser TRule
parseRule = do
  nonTerminal <- parseNonTerminal
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
  start <- parseNonTerminal
  newLine
  rules <- parseRules
  return $ TCFGrammar nonTerminals terminals start rules

parseCFG :: String -> Either ParseError TCFGrammar
parseCFG = parse cFG ""

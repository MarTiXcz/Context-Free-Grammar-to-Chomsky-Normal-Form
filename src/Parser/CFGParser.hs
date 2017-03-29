module Parser.CFGParser
  ( parseCFG
  ) where

import Text.ParserCombinators.Parsec
import Type.CFGParser

comma :: Parser Char
comma = char ','

parseNonTerminal :: Parser TNonTerminal 
parseNonTerminal = do
      x <- many1 upper
      y <- optionMaybe $ char '\''
      case y of
        Nothing -> return x 
        Just a -> return $ x ++ [a]

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
  TCFGrammar <$> (parseNonTerminals <* newLine)
  <*> (parseTerminal <* newLine)
  start <- parseNonTerminal
  newLine
  rules <- parseRules

parseCFG :: String -> Either ParseError TCFGrammar
parseCFG = parse cFG ""

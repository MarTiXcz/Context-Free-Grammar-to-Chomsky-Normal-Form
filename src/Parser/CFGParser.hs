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
-- using Applicative functors
-- parseRule = TRule 
--   <$> (parseNonTerminal <* arrow) 
--   <*> many1 letter
-- HINDENT produces this:
-- parseRule = TRule <$> (parseNonTerminal <* arrow) <*> many1 letter
-- I left implementation with do monad, because it's more readable(for me atleast).

newLine :: Parser Char
newLine = char '\n'

parseRules :: Parser [TRule]
parseRules =
  many1 $ do
    rule <- parseRule
    newLine
    return rule

--Control.Applicative 
--HIndent formats it like this. Could use some new lines.
cFG :: Parser TCFGrammar
cFG =
  TCFGrammar <$> (parseNonTerminals <* newLine) <*> (parseTerminals <* newLine) <*>
  (parseNonTerminal <* newLine) <*>
  parseRules

parseCFG :: String -> Either ParseError TCFGrammar
parseCFG = parse cFG ""

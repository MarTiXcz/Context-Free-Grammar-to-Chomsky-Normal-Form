module Type.CFGParser where

import Data.Char

type TSymbol = Char

type TNonTerminal = [TSymbol]

type TTerminal = TSymbol

data TRule = TRule
  { tNonTerminal :: TNonTerminal
  , tExpression :: [TSymbol]
  } deriving (Show)

data TCFGrammar = TCFGrammar
  { tNonTerminals :: [TNonTerminal]
  , tTerminals :: [TTerminal]
  , tStartNonTerminal :: TNonTerminal
  , tRules :: [TRule]
  } deriving (Show)

isOneNonTerminal :: [TSymbol] -> Bool
isOneNonTerminal [x] = isUpper x
--isOneNonTerminal (x:xs) = False
isOneNonTerminal _ = False

isTwoNonTerminals :: [TSymbol] -> Bool
isTwoNonTerminals [x, y] = isOneNonTerminal [x] && isOneNonTerminal [y]
--isTwoNonTerminals (x:xs) = False
isTwoNonTerminals _ = False

isOneTerminal :: [TSymbol] -> Bool
isOneTerminal [x] = isLower x
isOneTerminal (x:xs) = False
isOneTerminal _ = False

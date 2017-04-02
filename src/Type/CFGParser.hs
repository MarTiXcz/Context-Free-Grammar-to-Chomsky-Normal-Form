module Type.CFGParser where

import Data.Char

type TSymbol = Char

type TNonTerminal = [TSymbol]

type TTerminal = TSymbol

data TRule = TRule
  { tNonTerminal :: TNonTerminal
  , tExpression :: [TSymbol]
  } deriving (Show, Eq)

data TCFGrammar = TCFGrammar
  { tNonTerminals :: [TNonTerminal]
  , tTerminals :: [TTerminal]
  , tStartNonTerminal :: TNonTerminal
  , tRules :: [TRule]
  } deriving (Show)

--Not sure if these functions should be here. But they seem like type extension methods.

isOneNonTerminal :: [TSymbol] -> Bool
isOneNonTerminal [x] = isUpper x
isOneNonTerminal _ = False

isTwoNonTerminals :: [TSymbol] -> Bool
isTwoNonTerminals [x, y] = isOneNonTerminal [x] && isOneNonTerminal [y]
isTwoNonTerminals _ = False

isOneTerminal :: [TSymbol] -> Bool
isOneTerminal [x] = isLower x
-- isOneTerminal (x:xs) = False
isOneTerminal _ = False

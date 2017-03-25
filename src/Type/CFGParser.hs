module Type.CFGParser where

type TNonTerminal = Char

type TTerminal = Char

data TRule = TRule
  { tNonTerminal :: TNonTerminal
  , tExpression :: String
  } deriving (Show)

data TCFGrammar = TCFGrammar
  { tNonTerminals :: [TNonTerminal]
  , tTerminals :: [TTerminal]
  , tStartTerminal :: TTerminal
  , tRules :: [TRule]
  } deriving (Show)

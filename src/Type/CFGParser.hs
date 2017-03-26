module Type.CFGParser where

type TSymbol = Char
type TNonTerminal = TSymbol
type TTerminal = TSymbol

data TRule = TRule
  { tNonTerminal :: TNonTerminal
  , tExpression :: [TSymbol]
  } deriving (Show)

data TCFGrammar = TCFGrammar
  { tNonTerminals :: [TNonTerminal]
  , tTerminals :: [TTerminal]
  , tStartTerminal :: TTerminal
  , tRules :: [TRule]
  } deriving (Show)

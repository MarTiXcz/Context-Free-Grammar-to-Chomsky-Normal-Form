module CFGAlgorithms
  ( removeSimpleRules
  , convertToCNF
  ) where

import Data.Char
import Data.List (foldl') -- https://www.well-typed.com/blog/2014/04/fixing-foldl/

import Type.CFGParser

-- Rules.Where(rule => nonT.Contains(x.nonterminal) && rule.expression.isSingleNonTerminal())
getNonTerminals :: [TRule] -> [TNonTerminal] -> [TNonTerminal]
getNonTerminals rules [] = []
getNonTerminals rules [nonTerm] =
  let nonT =
        map
          tExpression
          (filter
             (\rule ->
                isOneNonTerminal (tExpression rule) &&
                tNonTerminal rule == nonTerm)
             rules)
  in nonTerm : getNonTerminals rules nonT
getNonTerminals rules (x:xs) = x : getNonTerminals rules xs

--equivalent to getNonTerminals, but using where instead of let
getNonTerminals' :: [TRule] -> [TNonTerminal] -> [TNonTerminal]
getNonTerminals' rules [] = []
getNonTerminals' rules [nonTerm] = nonTerm : getNonTerminals' rules nonT
  where
    nonT =
      map
        tExpression
        (filter
           (\rule ->
              isOneNonTerminal (tExpression rule) &&
              tNonTerminal rule == nonTerm)
           rules)
getNonTerminals' rules (x:xs) = x : getNonTerminals' rules xs

createRulesWithoutSimple :: [TRule] -> [TNonTerminal] -> [TRule]
createRulesWithoutSimple rules =
  foldl
    (\list nonTerminal -> (list ++ getRulesForNonTerminal nonTerminal rules))
    []

--nejspis vyhodnocuje getNonTerminals zbytecne vickrat
getRulesForNonTerminal :: TNonTerminal -> [TRule] -> [TRule]
getRulesForNonTerminal nonTerminal rules =
  map
    (TRule nonTerminal . tExpression)
    (filter
       (\rule ->
          not (isOneNonTerminal (tExpression rule)) &&
          --if nonterminal on left side is in Na set.
          elem (tNonTerminal rule) (getNonTerminals' rules [nonTerminal]))
       rules)

--creates new grammar from old but with new Rules
removeSimpleRules :: TCFGrammar -> TCFGrammar
removeSimpleRules originalGrammar =
  TCFGrammar
    (tNonTerminals originalGrammar)
    (tTerminals originalGrammar)
    (tStartNonTerminal originalGrammar)
    (createRulesWithoutSimple
       (tRules originalGrammar)
       (tNonTerminals originalGrammar))

createCNFRules :: [TRule] -> [TRule]
createCNFRules rules =
  removeDupliciteRules $
  --creates new rules for every rule not in CNF form (with duplicites)
  foldl
    (\list rule ->
       list ++ createCNFRulesFromRule (tNonTerminal rule) (tExpression rule))
    []
    rules

convertToCNF :: TCFGrammar -> TCFGrammar
convertToCNF originalGrammar =
  TCFGrammar
    (addNewNonterminalsFromRules (tNonTerminals originalGrammar) rules)
    (tTerminals originalGrammar)
    (tStartNonTerminal originalGrammar)
    rules
  where
    rules = createCNFRules (tRules originalGrammar)

createCNFRulesFromRule :: TNonTerminal -> [TSymbol] -> [TRule]
createCNFRulesFromRule nonTerminal expression
  | isOneTerminal expression = [TRule nonTerminal expression]
  | isTwoNonTerminals expression = [TRule nonTerminal expression]
  --expression starts with nonterminal and is longer than 2
  | length expression > 2 && isOneNonTerminal [firstSymbol] =
    TRule nonTerminal (firstSymbol : getNameForNewNonTerminal restExpression) :
    --join with rules for rest of the expression
    createCNFRulesFromRule
      (getNameForNewNonTerminal restExpression)
      restExpression
  --expression starts with terminal and is longer than 2
  | length expression > 2 && isOneTerminal [firstSymbol] =
    TRule
      nonTerminal
      (getNameForNonTerminalFromTerminal firstSymbol ++
       getNameForNewNonTerminal restExpression) :
    --rule for newNonTerminalFromTerminal -> terminal
    (TRule (getNameForNonTerminalFromTerminal firstSymbol) [firstSymbol] :
    --join with rules for rest of the expression
     createCNFRulesFromRule
       (getNameForNewNonTerminal restExpression)
       restExpression)
  | isLower firstSymbol =
    TRule
      nonTerminal
      (getNameForNonTerminalFromTerminal firstSymbol ++ restExpression) :
    --rule for newNonTerminalFromTerminal -> terminal
    [TRule (getNameForNonTerminalFromTerminal firstSymbol) [firstSymbol]]
  | length expression == 2 && isLower (head restExpression) =
    TRule
      nonTerminal
      (firstSymbol : getNameForNonTerminalFromTerminal (head restExpression)) :
    --rule for newNonTerminalFromTerminal -> terminal
    [ TRule
        (getNameForNonTerminalFromTerminal (head restExpression))
        [head restExpression]
    ]
  | otherwise = []
  where
    restExpression = tail expression
    firstSymbol = head expression
    -- secondSymbol = 

--not very effective, I could possibly use Data.Set for rules
removeDupliciteRules :: [TRule] -> [TRule]
removeDupliciteRules = foldl' (\list rule -> list ++ nonDuplicite list rule) []
  where
    nonDuplicite list rule =
      if rule `elem` list
        then []
        else [rule]

addNewNonterminalsFromRules :: [TNonTerminal] -> [TRule] -> [TNonTerminal]
addNewNonterminalsFromRules nonTerminals =
  foldl'
    (\list rule -> list ++ addNewNonterminal (tNonTerminal rule) nonTerminals)
    nonTerminals

--returns empty list if nonTerminal is already in nonTerminals else returns nonTerminal in list for concatenation
addNewNonterminal :: TNonTerminal -> [TNonTerminal] -> [TNonTerminal]
addNewNonterminal nonTerminal nonTerminals =
  if nonTerminal `elem` nonTerminals
    then []
    else [nonTerminal]

getNameForNewNonTerminal :: [TSymbol] -> TNonTerminal
getNameForNewNonTerminal expression = "<" ++ expression ++ ">"

getNameForNonTerminalFromTerminal :: TTerminal -> TNonTerminal
getNameForNonTerminalFromTerminal terminal = [terminal, '\'']

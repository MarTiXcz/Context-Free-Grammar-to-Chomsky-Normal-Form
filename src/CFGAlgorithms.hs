module CFGAlgorithms where

import Data.Char

--  ( simpleRules
--   , cNFform
--   )
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

--equivalent to getNonTerminals, but using where isntead of let
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
createCNFRules =
  filter
    (\rule ->
       isOneTerminal (tExpression rule) || isTwoNonTerminals (tExpression rule))

convertToCNF :: TCFGrammar -> TCFGrammar
convertToCNF originalGrammar = undefined

somethingRule :: TRule -> [TRule]
somethingRule rule
  | isOneTerminal (tExpression rule) = [rule]
  | isTwoNonTerminals (tExpression rule) = [rule]
  | length (tExpression rule) > 2 =
    createCNFRulesFromRule (tNonTerminal rule) (tExpression rule)

createCNFRulesFromRule :: TNonTerminal -> [TSymbol] -> [TRule]
createCNFRulesFromRule nonTerminal expression
  | isOneNonTerminal [head expression] =
    TRule
      nonTerminal
      (head expression : getNameForNewNonTerminal (tail expression)) :
    --join with rules for rest of the expression
    createCNFRulesFromRule (getNameForNewNonTerminal (tail expression)) (tail expression)
  | isOneTerminal [head expression] = 
    TRule
        (getNameForNonTerminalFromTerminal (head expression))
        (head expression : getNameForNewNonTerminal (tail expression)) :
      --join with rules for rest of the expression
      createCNFRulesFromRule (getNameForNewNonTerminal (tail expression)) (tail expression)

getNameForNewNonTerminal :: [TSymbol] -> TNonTerminal
getNameForNewNonTerminal expression = "<" ++ expression ++ ">"

getNameForNonTerminalFromTerminal :: TTerminal -> TNonTerminal
getNameForNonTerminalFromTerminal terminal = [terminal, '\'']
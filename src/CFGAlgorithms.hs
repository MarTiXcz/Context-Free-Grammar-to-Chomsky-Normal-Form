module CFGAlgorithms where

import Data.Char

--  ( simpleRules
--   , cNFform
--   )
import Type.CFGParser

isOneNonTerminal :: [TSymbol] -> Bool
isOneNonTerminal [x] = isUpper x
isOneNonTerminal (x:xs) = False
isOneNonTerminal _ = False

getNonTerminals :: [TRule] -> [TNonTerminal] -> [TNonTerminal]
-- Rules.Where(x => nonT.Contains(x.nonterminal) && x.expression.isSingleNonTerminal)
getNonTerminals rules [] = []
getNonTerminals rules [nonTerm] =
  let nonT =
        map
          (head . tExpression)
          (filter
             (\rule ->
                isOneNonTerminal (tExpression rule) &&
                tNonTerminal rule == nonTerm)
             rules)
  in nonTerm : getNonTerminals rules nonT
getNonTerminals rules (x:xs) = x : getNonTerminals rules xs

-- getNonTerminals :: [TRule] -> [TNonTerminal] -> [TNonTerminal]
-- getNonTerminals rules [] = []
-- getNonTerminals rules [nonTerm] = getNonTerminals rules $ nonT nonTerm
--   where
--     nonT nonT'=
--       map
--         (head . tExpression)
--         (filter
--            (\rule ->
--               isOneNonTerminal (tExpression rule) &&
--               tNonTerminal rule == nonT')
--            rules)
-- getNonTerminals rules (x:xs) = x : getNonTerminals rules xs
createNewRules :: [TNonTerminal] -> [TRule] -> [TRule]
createNewRules _ [] = []
createNewRules [] rules = []
createNewRules (nonTerminal:rest) rules =
  getRulesForNonTerminal nonTerminal rules ++ createNewRules rest rules

--TODO: nejspis vyhodnocuje getNonTerminals zbytecne vickrat
getRulesForNonTerminal :: TNonTerminal -> [TRule] -> [TRule]
getRulesForNonTerminal nonTerminal rules =
  map
    (TRule nonTerminal . tExpression)
    (filter
       (\rule ->
          not (isOneNonTerminal (tExpression rule)) &&
          elem (tNonTerminal rule) (getNonTerminals rules [nonTerminal]))
       rules)
--creates new grammar from old but with new Rules
removeSimpleRules :: TCFGrammar -> TCFGrammar
removeSimpleRules originalGrammar =
  TCFGrammar
    (tNonTerminals originalGrammar)
    (tTerminals originalGrammar)
    (tStartTerminal originalGrammar)
    (createNewRules (tNonTerminals originalGrammar) (tRules originalGrammar))

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
-- Rules.Where(x => nonT.Contains(x.nonterminal) && x.expression.isSingleNeterminal)
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
-- getNonTerminals rules [nonTerm] = getNonTerminals rules nonT
--   where
--     nonT =
--       map
--         (head . tExpression)
--         (filter
--            (\rule ->
--               isOneNonTerminal (tExpression rule) &&
--               tNonTerminal rule == nonTerm)
--            rules)
-- getNonTerminals rules (x:xs) = x : getNonTerminals rules xs

removeSimpleRules :: TCFGrammar -> TCFGrammar
removeSimpleRules = undefined

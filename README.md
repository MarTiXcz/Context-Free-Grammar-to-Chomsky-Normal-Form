# BKG2CNF Documentation
### Martin Zemek 
#### zemek.m@gmail.com (xzemek04@stud.fit.vutbr.cz)                                                              

## Build and Run             
Use STACK BUILD.
    
    stack build  flp-fun-xzemek04 
    stack exec flp-fun-xzemek04-exe -- -i resources\test.txt

using libraries:

    parsec
    optparse-applicative

Main is in app/Main.hs  
Test main is in test/Spec.hs. Program arguments are hardcoded there.

## Known bugs
none - everything should work.

## Limitations
nonterminals = [A-Z]  
terminals = [a-z]  
rules are without epsilon transitions.  
structure of input:

    <list of nonterminals>\n
    <list of terminals>\n
    <starting neterminal>\n
    <rule 1>\n
    ...
    <rule N>\n
example of input:  
    
    S,A,B
    a,b
    S
    S->aAB
    S->BA
    A->BBB
    A->a
    B->AS
    B->b
    (newline)

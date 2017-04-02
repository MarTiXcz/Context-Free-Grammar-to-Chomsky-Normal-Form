# BKG2CNF Documentation
## Author
### Martin Zemek 
student xzemek04 at [Brno university of Technology](www.fit.vutbr.cz)  
email: zemek.m@gmail.com (xzemek04@stud.fit.vutbr.cz)

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
None - everything should work.

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

## Notable sources
[https://github.com/pcapriotti/optparse-applicative](https://github.com/pcapriotti/optparse-applicative)  
[http://blog.jakubarnold.cz/2014/08/10/parsing-css-with-parsec.html](http://blog.jakubarnold.cz/2014/08/10/parsing-css-with-parsec.html)  
[http://book.realworldhaskell.org/read/using-parsec.html](http://book.realworldhaskell.org/read/using-parsec.html)

## Thanks
#### [Ing. Marek Kidoň](https://github.com/Tr1p0d)  – for great lab exercises and very helpful consultation on project.
// 1) 
// foreach nonterminal A sestrojit mnozinu
// NA 
// a) N0 = {A}, i=1
// b) Ni = {C | pravidlo B -> C je v Rules && B je v Ni-1} sjednoceno s Ni-1
// c) if Ni != Ni-1
//     then i = i +1; do b)
//     else NA = Ni

// 2)
// if B -> alpha je v Rules a není jednoduchým pravidlem
//     then foreach (A | B patří NA){
//         Rules'.Add( A -> alpha)
//     }
// 3) použít Rules' 

// Na[0]
struct Rule = {
    string nonterminal,
    string alpha
};
var nonterminals = new List<string>();
var P = new List<Rule>();
P.Add(new Rule {"E","EpT"});
P.Add(new Rule {"E","T"});
P.Add(new Rule {"T","TmF"});

var allNonT = new List<List<string>>();
foreach (var A in nonterminals)
{
    var nonT = new List<string>();
    nonT.Add(A);
    
    do
    {
        var count = nonT.count();
        addNT();           
    } while (nonT.Count != count);
    allNonT.Add(nonT);
}

//refactored
private void addNT()
{   
    foreach (var rule in P.Where(x => nonT.Contains(x.nonterminal) 
    && x.expression.isSingleNeterminal()))
    {
            nonT.Add(r.expression)    
    }

}
//original 
private void addNTOriginal()
{
    foreach (var B in nonT)
    {
        foreach (var rule in P)
        {
            if (rule.nonterminal == B && rule.expression.isSingleNeterminal)
            {
                nonT.Add(C)    
            } 
        }
    }
}


//alternative
foreach (var A in nonterminals)
{
    var nonT = new List<string>();
    nonT.Add(A);
    
    do
    {
        var count = nonT.count();
        addNT();           
    } while (nonT.Count != count);
    allNonT.Add(nonT);
}

//refactored
private List<string> addNT()
{   
    var newNonT = new List<string>();
    foreach (var rule in P.Where(x => nonT.Contains(x.nonterminal)
    && x.expression.isSingleNeterminal))
    {
            newNonT.Add(r.expression);    
    }
    
}

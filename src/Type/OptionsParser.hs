module Type.OptionsParser where
    
data Mode = PrintMode | SimpleMode | CnfMode
    deriving Show

data Opts = Opts 
    { mode :: Mode
    , filepath :: FilePath
    }
    deriving Show

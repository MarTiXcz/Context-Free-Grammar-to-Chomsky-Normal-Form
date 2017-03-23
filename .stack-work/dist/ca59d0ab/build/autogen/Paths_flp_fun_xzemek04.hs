{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_flp_fun_xzemek04 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\Martin\\Dropbox\\FIT\\Masters\\8.semestr\\FLP\\Fun_project\\bkg\\flp-fun-xzemek04\\.stack-work\\install\\65995373\\bin"
libdir     = "C:\\Users\\Martin\\Dropbox\\FIT\\Masters\\8.semestr\\FLP\\Fun_project\\bkg\\flp-fun-xzemek04\\.stack-work\\install\\65995373\\lib\\x86_64-windows-ghc-8.0.2\\flp-fun-xzemek04-0.1.0.0-FpSIZxxNtcn4P8YM06k4YV"
dynlibdir  = "C:\\Users\\Martin\\Dropbox\\FIT\\Masters\\8.semestr\\FLP\\Fun_project\\bkg\\flp-fun-xzemek04\\.stack-work\\install\\65995373\\lib\\x86_64-windows-ghc-8.0.2"
datadir    = "C:\\Users\\Martin\\Dropbox\\FIT\\Masters\\8.semestr\\FLP\\Fun_project\\bkg\\flp-fun-xzemek04\\.stack-work\\install\\65995373\\share\\x86_64-windows-ghc-8.0.2\\flp-fun-xzemek04-0.1.0.0"
libexecdir = "C:\\Users\\Martin\\Dropbox\\FIT\\Masters\\8.semestr\\FLP\\Fun_project\\bkg\\flp-fun-xzemek04\\.stack-work\\install\\65995373\\libexec"
sysconfdir = "C:\\Users\\Martin\\Dropbox\\FIT\\Masters\\8.semestr\\FLP\\Fun_project\\bkg\\flp-fun-xzemek04\\.stack-work\\install\\65995373\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "flp_fun_xzemek04_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "flp_fun_xzemek04_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "flp_fun_xzemek04_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "flp_fun_xzemek04_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "flp_fun_xzemek04_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "flp_fun_xzemek04_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)

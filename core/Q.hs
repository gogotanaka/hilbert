{- |
Module      : Language.Q
Copyright   : Kazuki Tanaka (a.k.a gogotanaka)
Licence     : MIT

q-language.org.
-}

module Q
       ( module Q.Lexer
       , module Q.Parser
       , version
       ) where


import Q.Lexer
import Q.Parser

import Data.Version

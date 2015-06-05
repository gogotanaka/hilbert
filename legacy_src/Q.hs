{- |
Module      : Language.Hilbert
Copyright   : Kazuki Tanaka (a.k.a gogotanaka)
Licence     : MIT

q-language.org.
-}

module Hilbert
       ( module Hilbert.Lexer
       , module Hilbert.Parser
       , version
       ) where


import Hilbert.Lexer
import Hilbert.Parser

import Data.Version

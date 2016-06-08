module Test.Main where

import Prelude
import Data.Pair (Pair)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Eff.Random (RANDOM)
import Control.Monad.Eff.Console (CONSOLE)

import Type.Proxy (Proxy(..), Proxy2(..))
import Test.QuickCheck.Laws.Data.Eq (checkEq)
import Test.QuickCheck.Laws.Data.Ord (checkOrd)
import Test.QuickCheck.Laws.Data.Functor (checkFunctor)
import Test.QuickCheck.Laws.Control.Apply (checkApply)
import Test.QuickCheck.Laws.Control.Applicative (checkApplicative)
import Test.QuickCheck.Laws.Control.Bind (checkBind)
import Test.QuickCheck.Laws.Control.Monad (checkMonad)
import Test.QuickCheck.Laws.Data.Semigroup (checkSemigroup)
import Test.QuickCheck.Laws.Data.Monoid (checkMonoid)

proxyNumber :: Proxy (Pair Number)
proxyNumber = Proxy

proxyString :: Proxy (Pair String)
proxyString = Proxy

proxy2 :: Proxy2 Pair
proxy2 = Proxy2

main :: Eff (console :: CONSOLE, random :: RANDOM, err :: EXCEPTION) Unit
main = do
  checkEq proxyNumber
  checkOrd proxyNumber
  checkFunctor proxy2
  checkApply proxy2
  checkApplicative proxy2
  checkBind proxy2
  checkMonad proxy2
  checkSemigroup proxyString
  checkMonoid proxyString

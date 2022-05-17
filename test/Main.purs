module Test.Main where

import Prelude

import Type.Proxy (Proxy(..))

import Data.Array (cons, snoc, fromFoldable)
import Data.Pair (Pair(..), (~), fst, snd, swap, uncurry)
import Data.Foldable (foldMap, foldr, foldl, product, sum)
import Data.Traversable (sequence)
import Data.Distributive (distribute, collect)
import Data.Maybe (Maybe(..))

import Effect (Effect)

import Test.Assert (assert)

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

proxy2 :: Proxy Pair
proxy2 = Proxy

type Point = Pair Int

point :: Int -> Int -> Point
point = Pair

main :: Effect Unit
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

  let p1 = point 2 3
      p2 = point 4 7
      square x = x * x

  assert $ fst p1 == 2
  assert $ snd p1 == 3
  assert $ swap p1 == point 3 2
  assert $ map (_ + 1) p1 == point 3 4
  assert $ (sum <<< map square) p1 == 13
  assert $ p2 > p1
  assert $ product p2 == 28
  assert $ show p1 == "(2 ~ 3)"
  assert $ foldMap show p1 == "23"
  assert $ fromFoldable p1 == [2, 3]
  assert $ foldr cons [] p1 == [2, 3]
  assert $ foldl snoc [] p1 == [2, 3]
  assert $ ((+) <$> p1 <*> p2) == point 6 10
  assert $ (uncurry (+) p1) == 5
  assert $ sequence (Just 2 ~ Just 5) == Just (2 ~ 5)
  assert $ sequence (Just 2 ~ Nothing) == Nothing
  assert $ distribute [2 ~ 3, 4 ~ 5] == [2, 4] ~ [3, 5]
  assert $ collect (\x -> x ~ square x) [1, 2, 3] == [1, 2, 3] ~ [1, 4, 9]

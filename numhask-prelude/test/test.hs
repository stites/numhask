{-# OPTIONS_GHC -Wall #-}

-- | testing IEEE numbers is a special kind of hell, and one that I reserve for days when I can hardly think, so please forgive the horrible hackery contained within this file.
--
-- This suite sometimes fails, having been hand-crafty towards balancing reasonably approximate equality versus unbounded failure (given enough trials).
module Main where

import NumHask.Prelude
import NumHask.Laws

import Test.DocTest
import Test.Tasty
       (TestTree, defaultMain, testGroup)

main :: IO ()
main = do
  doctest ["src/NumHask/Examples.hs"]
  defaultMain tests

tests :: TestTree
tests =
  testGroup
    "NumHask"
    [ testsInt
    , testsFloat
    , testsBool
    , testsComplexFloat
    ]

testsInt :: TestTree
testsInt =
  testGroup
    "Int"
    [ testGroup "Additive" $ testLawOf ([] :: [Int]) <$> additiveLaws
    , testGroup "Additive Group" $ testLawOf ([] :: [Int]) <$> additiveGroupLaws
    , testGroup "Multiplicative" $
      testLawOf ([] :: [Int]) <$> multiplicativeLaws
    , testGroup "Distribution" $ testLawOf ([] :: [Int]) <$> distributionLaws
    , testGroup "Integral" $ testLawOf ([] :: [Int]) <$> integralLaws
    , testGroup "Signed" $ testLawOf ([] :: [Int]) <$> signedLaws
    , testGroup "Normed" $ testLawOf2 ([] :: [(Int, Int)]) <$> normedLaws
    , testGroup "Metric" $ testLawOf2 ([] :: [(Int, Int)]) <$> metricLaws
    ]

testsFloat :: TestTree
testsFloat =
  testGroup
    "Float"
    [ testGroup "Additive - Associative Fail" $
      testLawOf ([] :: [Float]) <$> additiveLawsFail
    , testGroup "Additive Group" $
      testLawOf ([] :: [Float]) <$> additiveGroupLaws
    , testGroup "Multiplicative - Associative Fail" $
      testLawOf ([] :: [Float]) <$> multiplicativeLawsFail
    , testGroup "MultiplicativeGroup" $
      testLawOf ([] :: [Float]) <$> multiplicativeGroupLaws_
    , testGroup "Distribution - Fail" $
      testLawOf ([] :: [Float]) <$> distributionLawsFail
    , testGroup "Signed" $ testLawOf ([] :: [Float]) <$> signedLaws
    , testGroup "Normed" $ testLawOf2 ([] :: [(Float, Float)]) <$> normedLaws
    , testGroup "Metric" $ testLawOf2 ([] :: [(Float, Float)]) <$> metricLaws
    , testGroup "Bounded Field" $
      testLawOf ([] :: [Float]) <$> boundedFieldLaws
    , testGroup "Quotient Field" $
      testLawOf ([] :: [Float]) <$> quotientFieldLaws
    , testGroup "Exponential Field" $ testLawOf2 ([] :: [(Float,Float)]) <$> expFieldLaws
    ]

testsBool :: TestTree
testsBool =
  testGroup
    "Bool"
    [ testGroup "Idempotent" $ testLawOf ([] :: [Bool]) <$> idempotentLaws
    , testGroup "Additive" $ testLawOf ([] :: [Bool]) <$> additiveLaws
    , testGroup "Multiplicative" $
      testLawOf ([] :: [Bool]) <$> multiplicativeLaws
    , testGroup "Distribution" $ testLawOf ([] :: [Bool]) <$> distributionLaws
    ]

testsComplexFloat :: TestTree
testsComplexFloat =
  testGroup
    "Complex Float"
    [ testGroup "Additive - Associative Fail" $
      testLawOf ([] :: [Complex Float]) <$> additiveLawsFail
    , testGroup "Additive Group" $
      testLawOf ([] :: [Complex Float]) <$> additiveGroupLaws
    , testGroup "Multiplicative - Associative Fail" $
      testLawOf ([] :: [Complex Float]) <$> multiplicativeLawsFail
    , testGroup "MultiplicativeGroup" $
      testLawOf ([] :: [Complex Float]) <$> multiplicativeGroupLaws_
    , testGroup "Distribution - Fail" $
      testLawOf ([] :: [Complex Float]) <$> distributionLawsFail
    -- , testGroup "Exponential Field" $
    --   testLawOf2 ([] :: [(Complex Float, Float)]) <$> expFieldLaws 
    , testGroup "Normed" $ testLawOf2 ([] :: [(Complex Float, Float)]) <$>
      normedLaws
    , testGroup "Metric" $ testLawOf2 ([] :: [(Complex Float, Float)]) <$>
      metricLaws
    , testGroup "Involutive Ring" $ testLawOf ([] :: [Complex Float]) <$>
      involutiveRingLaws
    ]


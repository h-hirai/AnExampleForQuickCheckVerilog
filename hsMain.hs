{-# LANGUAGE ForeignFunctionInterface #-}

module HsMain where

import Test.QuickCheck
import Test.QuickCheck.Property
import Data.Int (Int8, Int16)
import Data.List (inits)

prop_Accum :: [Int8] -> Property
prop_Accum integers = morallyDubiousIOProperty $ do
  reset
  actuals <- mapM write_data integers
  return $ actuals == expects
  where expects = map sum $ tail $ map (map fromIntegral) $ inits integers

hsMain :: IO ()
hsMain = quickCheck prop_Accum

foreign export ccall hsMain :: IO ()
foreign import ccall reset :: IO ()
foreign import ccall write_data :: Int8 -> IO Int16

{-# LANGUAGE ForeignFunctionInterface #-}

module HsMain where

import Test.QuickCheck
import Test.QuickCheck.Property
import Data.Int (Int8, Int16)
import Data.List (inits)

prop_Accum :: [Int8] -> Property
prop_Accum is = morallyDubiousIOProperty $ do
  reset
  as <- mapM write_data is
  return $ as == es
  where es = map sum $ tail $ map (map fromIntegral) $ inits is

hsMain :: IO ()
hsMain = do
  quickCheck prop_Accum
  return ()

foreign export ccall hsMain :: IO ()
foreign import ccall reset :: IO ()
foreign import ccall write_data :: Int8 -> IO Int16

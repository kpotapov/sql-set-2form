module SqlTable( Table(CTable),runS, run,tableInsertSql )  where

import Text.ParserCombinators.Parsec
import Data.List
import System
import Text.Parsec.Error


data Table  = CTable { tname :: String , theader :: [String], tvalues :: [[String]] }
instance Show Table where
  show (CTable n h v) = show n ++ " " ++ show h ++ " " ++ show v


runS :: Parser Table -> String -> String
runS p input
        = case (parse p "" input) of
            Left err -> "parse error at " ++ (show err )
            Right x  -> tableInsertSql x

run :: Show a => Parser a -> String -> IO ()
run p input
        = case (parse p "" input) of
            Left err -> do{ putStr "parse error at "
                          ; print err
                          }
            Right x  -> print x
            
            

-- get a table , return a string representation of the sql
tableInsertSql :: Table -> String 
tableInsertSql t = let sets = map (set ( theader t) ) (tvalues t)
                   in concat ( map (tableInsertHeader t) (map (intercalate ", " )  sets) ) 

tableInsertHeader :: Table -> String -> String
tableInsertHeader t s = " INSERT INTO " ++ tname  t  ++" SET " ++ s ++ ";"

set :: [String] -> [String] -> [String]
set n v  = map (\x-> fst x ++ "=" ++ snd x ) ( zip n v )

            

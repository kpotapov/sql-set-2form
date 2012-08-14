module Main where

import Text.ParserCombinators.Parsec
import Data.List
import System
import Text.Parsec.Error
import IO
import SqlTable 

-- it doesn't devide the input string by subsctrings delemited by spaces

main = 
  do sql <- hGetLine stdin
     print sql
     putStrLn ""
     let outSql = runS sqlStr3 sql
     print outSql

-- TODO unit tests
sqlStr3 :: Parser Table
sqlStr3 = do{ string "INSERT"
              ; skipMany1 (space)
              ; string "INTO"
              ; skipMany (space)
              ; tableName <- name
              ; skipMany (space)
              ; char '('
              ; skipMany (space)
              ; fieldNames <- names
              ; skipMany (space)
              ; char ')'  
              ; skipMany (space)
              ; string "VALUES"
              ; skipMany (space)
              ; __values <- sepBy1 embrasedValues separator
              ; return ( CTable tableName fieldNames __values )
              }            


fields    :: Parser [String]
fields   = sepBy1 word separator

separator   :: Parser ()
separator   = skipMany1 (space <|> char ',')

names :: Parser [String]
names = sepBy1 name separator
        

name :: Parser String
name = do{  char '`'
            ; _name <- word
            ;char '`'
            ;return _name
         }
       <|> word
       
embrasedValues :: Parser [String]
embrasedValues  = do { char '('
                     ; skipMany (space)
                     ; _values <- values
                     ; skipMany (space)
                     ; char ')'
                     ;return _values
                     }

values :: Parser [String]
values = sepBy1 value separator

value :: Parser String
value = do{  char '\'' <|> char '"'
            ; _value <- wd
            ;char '\'' <|> char '"'
            ;return $ "'"++_value++"'"
         }
       <|> word

wd :: Parser String
wd = many (noneOf "'\"")

word    :: Parser String
word    = many1 ( letter  <|> char '_'  <|> digit)


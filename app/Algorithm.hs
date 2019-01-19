module Algorithm
      ( findSecretWord
      ) where

import Data.List (isInfixOf, transpose)
import Data.Char (toLower, toUpper)
import Data.List.Utils (replace) -- TODO  install MissingH

type Board = [String]

printBoard :: Board -> IO ()
printBoard board = putStrLn (unlines board)

toLowerString :: String -> String
toLowerString str = [ toLower x | x <- str]

toUpperString :: String -> String
toUpperString str = [ toUpper x | x <- str]

findWordOnBoardInRows :: Board -> String -> Bool
findWordOnBoardInRows [] _ = False
findWordOnBoardInRows (x:xs) word = (||) (findWordInRow word x) (findWordOnBoardInRows xs word)

findWordInRow :: String -> String -> Bool
findWordInRow word line = isInfixOf word line

replaceWordInRowIfExists :: String -> [String] -> [String]
replaceWordInRowIfExists _ [] = []
-- create method


crossOutWord :: Board -> String -> Board
crossOutWord (b:bx) word = (replace (toLowerString word) (toUpperString word) b) ++ (crossOutWord bx word)

-- transposes board
transposeBoard :: Board -> Board
transposeBoard board = transpose board

-- Cross out words on board and returns board with corssed out words - changed to upper case.
crossOutWords :: Board -> [String] -> Board
crossOutWords [] _ = []
crossOutWords board [] = board
crossOutWords board (w:wx) = crossOutWords (crossOutWord board w) wx

-- Cross out words in all directions and return board in basic version
crossOutWordsInAllDirections :: Board -> [String] -> Board
crossOutWordsInAllDirections [] _ = []
crossOutWordsInAllDirections board wordList = crossOutWords (transposeBoard (crossOutWords board wordList)) wordList

-- gets all words that are not in uppercase
getWordFromCrossedOutBoard :: Board -> String
getWordFromCrossedOutBoard [] = ""
-- changes all characters to lowercase
getListWithLowerStrings :: [String] -> [String]
getListWithLowerStrings board = map toLowerString board

-- finds secret word on the board, list of words and returns secret word
findSecretWord :: [String] -> [String] -> String
findSecretWord [] _ = []
findSecretWord _ [] = []
findSecretWord board wordList = getWordFromCrossedOutBoard (crossOutWordsInAllDirections (getListWithLowerStrings board) wordList)

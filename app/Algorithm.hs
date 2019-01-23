module Algorithm
      ( findSecretWord
      	, printBoard
      ) where

import Data.List (isInfixOf, transpose)
import Data.Char (toLower, toUpper, isUpper, isLower)
import Data.List.Utils (replace)

type Board = [String]

printBoard :: Board -> IO ()
printBoard board = putStrLn (unlines board)

toLowerString :: String -> String
toLowerString str = [ toLower x | x <- str]

toUpperString :: String -> String
toUpperString str = [ toUpper x | x <- str]

--checks if word on board exists
findWordOnBoardInRows :: Board -> String -> Bool
findWordOnBoardInRows [] _ = False
findWordOnBoardInRows (x:xs) word = (||) (findWordInRow word x) (findWordOnBoardInRows xs word)

--cheks if word in line exists
findWordInRow :: String -> String -> Bool
findWordInRow word line = isInfixOf word line

-- probably not used
--replaceWordInRowIfExists :: String -> [String] -> [String]
--replaceWordInRowIfExists _ [] = []
-- TODO create method

-- replaces word eg replace "O" "X" "HELLO WORLD" -> "HELLX WXRLD"
replaceWord :: String -> String -> String -> String
replaceWord [] _ string = string
replaceWord firstString secondString baseString = replace firstString secondString baseString

crossOutWord :: [String] -> String -> [String]
crossOutWord [] _ = []
crossOutWord (b:bx) word = (replaceWord (toLowerString word) (toUpperString word) b) : (crossOutWord bx word) -- TODO fix this method

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
crossOutWordsInAllDirections board wordList = crossOutWords (transposeBoard (crossOutWords board wordList)) wordList --TODO add diagonall direction



-- gets word from crossed out line
getWordFromCrossedOutLine :: String -> String
getWordFromCrossedOutLine [] = ""
getWordFromCrossedOutLine (x:xs)
      | isLower x = x : getWordFromCrossedOutLine xs
      | otherwise = getWordFromCrossedOutLine xs

-- gets all words that are not in uppercase
getWordFromCrossedOutBoard :: Board -> String
getWordFromCrossedOutBoard [] = ""
getWordFromCrossedOutBoard (x:xs) = (getWordFromCrossedOutLine x) ++ (getWordFromCrossedOutBoard xs)



-- changes all characters to lowercase
getListWithLowerStrings :: [String] -> [String]
getListWithLowerStrings board = map toLowerString board

-- Finds secret word on the board, list of words and returns secret word. Algorithm starts here.
findSecretWord :: [String] -> [String] -> String
findSecretWord [] _ = []
findSecretWord _ [] = []
findSecretWord board wordList = getWordFromCrossedOutBoard (crossOutWordsInAllDirections (getListWithLowerStrings board) wordList)

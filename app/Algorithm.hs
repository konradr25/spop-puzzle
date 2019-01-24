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

toMaxChar :: Char -> Char -> Char
toMaxChar a b = min a b

toMaxChars :: String -> String -> String
toMaxChars [] _ = []
toMaxChars (w:wx) (w1:wx1) = (toMaxChar w w1) : (toMaxChars wx wx1)

joinAllOrienStrings :: String -> String -> String -> String -> String
joinAllOrienStrings vert hor diagLeft diagRight = (toMaxChars diagRight (toMaxChars diagLeft (toMaxChars vert hor)))

-- gets all words that are not in uppercase
boardToString :: Board -> String
boardToString [] = ""
boardToString (x:xs) = x ++ (boardToString xs)

toLowerString :: String -> String
toLowerString str = [ toLower x | x <- str]

toUpperString :: String -> String
toUpperString str = [ toUpper x | x <- str]

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

crossOutWordsHorizontally :: Board -> [String] -> Board
crossOutWordsHorizontally [] _ = []
crossOutWordsHorizontally board wordList = crossOutWords board wordList

crossOutWordsVertically :: Board -> [String] -> Board
crossOutWordsVertically [] _ = []
crossOutWordsVertically board wordList = transposeBoard (crossOutWords (transposeBoard board) wordList)

crossOutWordsDiagonally :: Board -> [String] -> Board
crossOutWordsDiagonally [] _ = []
crossOutWordsDiagonally board wordList = []

crossOutWordsDiagonally2 :: Board -> [String] -> Board
crossOutWordsDiagonally2 [] _ = []
crossOutWordsDiagonally2 board wordList = []

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
findSecretWord board wordList = getWordFromCrossedOutLine (toMaxChars (boardToString (crossOutWordsHorizontally (getListWithLowerStrings board) wordList)) (boardToString (crossOutWordsVertically (getListWithLowerStrings board) wordList)))

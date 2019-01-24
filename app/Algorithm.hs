module Algorithm
      ( findSecretWord
        , printBoard
        , prepareWordsToFind
      ) where

import Data.List (isInfixOf, transpose)
import Data.Char (toLower, toUpper, isUpper, isLower)
import Data.List.Utils (replace)

type Board = [String]

prepareWordsToFind :: Board -> Board
prepareWordsToFind [] = []
prepareWordsToFind (l:ls) = (replace " " "" (replace "-" "" l)) : (prepareWordsToFind ls)

printBoard :: Board -> IO ()
printBoard board = putStrLn (unlines board)

-- take bigger letter eg from AwAr and aWAr -> AWAr
toMaxChar :: Char -> Char -> Char
toMaxChar a b = min a b

toMaxChars :: String -> String -> String
toMaxChars [] _ = []
toMaxChars (w:wx) (w1:wx1) = (toMaxChar w w1) : (toMaxChars wx wx1)

toLowerString :: String -> String
toLowerString str = [ toLower x | x <- str]

toUpperString :: String -> String
toUpperString str = [ toUpper x | x <- str]

prefix:: String -> String
prefix [] = []
prefix line = '_' : line

-- modify board to enable diagonal search for words
toSkew :: Board -> Board
toSkew [] = []
toSkew (l:ls) = l : toSkew (map prefix ls)

skewBackward :: Board -> Board
skewBackward [] = []
skewBackward board = map reverse (reverse (toSkew (reverse (map reverse board))))

unskew :: Board -> Board
unskew [] = []
unskew (l:ls) = (replace "_" "" l) : (unskew ls)

joinAllOrienStrings :: String -> String -> String -> String -> String
joinAllOrienStrings vert hor diagDown diagUp = (toMaxChars diagUp (toMaxChars diagDown (toMaxChars vert hor)))

-- gets all words that are not in uppercase
boardToString :: Board -> String
boardToString [] = ""
boardToString (x:xs) = x ++ (boardToString xs)

diagonalizeDown :: Board -> Board
diagonalizeDown board = transpose (skewBackward (toSkew (map reverse board)))

undiagonalizeDown :: Board -> Board
undiagonalizeDown board = map reverse (unskew (transpose board))

diagonalizeUp :: Board -> Board
diagonalizeUp board = map reverse (transpose (skewBackward (toSkew board)))

undiagonalizeUp :: Board -> Board
undiagonalizeUp board = unskew (transpose (map reverse board))

-- replaces word eg replace "O" "X" "HELLO WORLD" -> "HELLX WXRLD"
replaceWord :: String -> String -> String -> String
replaceWord [] _ string = string
replaceWord firstString secondString baseString = replace firstString secondString baseString

crossOutWord :: [String] -> String -> [String]
crossOutWord [] _ = []
crossOutWord (b:bx) word = (replaceWord (toLowerString word) (toUpperString word) b) : (crossOutWord bx word)

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

crossOutWordsDiagonallyDown :: Board -> [String] -> Board
crossOutWordsDiagonallyDown [] _ = []
crossOutWordsDiagonallyDown board wordList = undiagonalizeDown (crossOutWords (diagonalizeDown board) wordList)

crossOutWordsDiagonallyUp :: Board -> [String] -> Board
crossOutWordsDiagonallyUp [] _ = []
crossOutWordsDiagonallyUp board wordList = undiagonalizeUp (crossOutWords (diagonalizeUp board) wordList)

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
findSecretWord board wordList =
  let horString = boardToString (crossOutWordsHorizontally (getListWithLowerStrings board) wordList)
      verString = boardToString (crossOutWordsVertically (getListWithLowerStrings board) wordList)
      diagDownString = boardToString (crossOutWordsDiagonallyDown (getListWithLowerStrings board) wordList)
      diagUpString = boardToString (crossOutWordsDiagonallyUp (getListWithLowerStrings board) wordList)
  in getWordFromCrossedOutLine (joinAllOrienStrings horString verString diagDownString diagUpString)

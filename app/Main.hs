module Main where

import Lib
import Algorithm
import System.IO
import Data.List (isInfixOf, transpose)

main :: IO ()
main = do

    -- Getting file content
    boardFileContent <- readFile "diag_board.txt"
    let boardLines = lines boardFileContent

    -- Getting file content
    wordsFileContent <- readFile "diag_words.txt"
    let wordsLines = lines wordsFileContent

    -- finding secret word
    printBoard boardLines
    printBoard (skew boardLines)
    printBoard (diagonalize boardLines)
    printBoard (undiagonalize (diagonalize boardLines))
    --printBoard (skew (undiagonalize (diagonalize boardLines)))
    --printBoard  (transpose (skew (undiagonalize (diagonalize boardLines))))
    --printBoard (transpose (skew boardLines))
    --printBoard (skew (transpose boardLines))
    --putStrLn (boardToString (unskew (skew boardLines)))

    let secretWord = findSecretWord boardLines wordsLines
    putStr "The secret word is "
    putStrLn secretWord

    putStrLn "Done"

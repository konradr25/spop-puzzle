module Main where

import Lib
import Algorithm
import System.IO

main :: IO ()
main = do

    -- Getting file content
    boardFileContent <- readFile "hor_board.txt"
    let boardLines = lines boardFileContent

    -- Getting file content
    wordsFileContent <- readFile "hor_words.txt"
    let wordsLines = lines wordsFileContent

    -- finding secret word
    putStrLn (boardToString (skew boardLines))

    let secretWord = findSecretWord boardLines wordsLines
    putStr "The secret word is "
    putStrLn secretWord

    putStrLn "Done"

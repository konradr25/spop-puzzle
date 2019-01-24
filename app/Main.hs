module Main where

import Lib
import Algorithm
import System.IO

main :: IO ()
main = do
    -- Get the file name of board
    putStr "What is the board definition filename? "
    hFlush stdout
    fileNameOfBoard <- getLine

    -- Getting file content
    boardFileContent <- readFile fileNameOfBoard
    let boardLines = lines boardFileContent

    -- Get the file name of words
    putStr "What is the filename of words? "
    hFlush stdout
    fileNameOfWords <- getLine

    -- Getting file content
    wordsFileContent <- readFile fileNameOfWords
    let wordsLines = lines wordsFileContent

    -- finding secret word
    putStrLn "Finding secret word"

    let secretWord = findSecretWord boardLines wordsLines
    putStr "The secret word is "
    putStrLn secretWord

    putStrLn "Done"
    
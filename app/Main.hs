module Main where

import Lib
import Algorithm
import System.IO

main :: IO ()
main = do

    {-boardFileContent <- readFile "puzzle1_board.txt"
    let boardLines = lines boardFileContent

    -- Getting file content
    wordsFileContent <- readFile "puzzle1_words.txt"
    let wordsLines = prepareWordsToFind (lines wordsFileContent)

    -- Getting file content
    putStrLn "PUZZLE 1 Board"
    printBoard boardLines
    putStrLn "PUZZLE 1 Words"
    printBoard wordsLines

     -- finding secret word
    let secretWord = findSecretWord boardLines wordsLines
    putStr "PUZZLE 1 The secret word is "
    putStrLn secretWord-}

    {-boardFileContent <- readFile "puzzle2_board.txt"
    let boardLines = lines boardFileContent

    -- Getting file content
    wordsFileContent <- readFile "puzzle2_words.txt"
    let wordsLines = prepareWordsToFind (lines wordsFileContent)

    -- Getting file content
    putStrLn "PUZZLE 2 Board"
    printBoard boardLines
    putStrLn "PUZZLE 2 Words"
    printBoard wordsLines

     -- finding secret word
    let secretWord = findSecretWord boardLines wordsLines
    putStr "PUZZLE 2 The secret word is "
    putStrLn secretWord-}

    {-boardFileContent <- readFile "puzzle3_board.txt"
    let boardLines = lines boardFileContent

    -- Getting file content
    wordsFileContent <- readFile "puzzle3_words.txt"
    let wordsLines = prepareWordsToFind (lines wordsFileContent)

    -- Getting file content
    putStrLn "PUZZLE 3 Board"
    printBoard boardLines
    putStrLn "PUZZLE 3 Words"
    printBoard wordsLines

     -- finding secret word
    let secretWord = findSecretWord boardLines wordsLines
    putStr "PUZZLE 3 The secret word is "
    putStrLn secretWord-}

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
    let wordsLines = prepareWordsToFind (lines wordsFileContent)

    putStrLn "BOARD"
    printBoard boardLines
    putStrLn "WORDS"
    printBoard wordsLines

    -- finding secret word
    putStrLn "Finding secret word"

    let secretWord = findSecretWord boardLines wordsLines
    putStr "The secret word is "
    putStrLn secretWord

    putStrLn "Done"
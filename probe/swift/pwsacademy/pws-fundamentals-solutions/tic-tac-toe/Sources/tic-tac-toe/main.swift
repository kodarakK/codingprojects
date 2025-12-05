/*
 Challenge 1: Tic-Tac-Toe.
 
 This file contains only the welcome message and the main loop.
 Most of the game's code is in game.swift.
 */

print("Welcome to Tic-Tac-Toe!")

var oneMoreGame = true
while oneMoreGame {
    print()
    playGame()
    oneMoreGame = readBool(question: "Would you like to play again?")
}

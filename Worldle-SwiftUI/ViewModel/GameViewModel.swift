//
//  GameViewModel.swift
//  Worldle-SwiftUI
//
//  Created by Hernán Rodríguez on 25/8/24.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var words: [[LetterState]]
    @Published var currentRow: Int = 0
    @Published var currentColumn: Int = 0
    @Published var gameStatusMessage: String = ""
    @Published var showResetButton: Bool = false
    @Published var letterCount: Int?
    
    private var wordModel: WordModel?
    private var allWords: Set<String> = []
    private let gameController = GameController()
    
    init() {
        self.words = []
    }
    
    func startGame(withLetterCount count: Int) {
        self.letterCount = count
        self.words = Array(repeating: Array(repeating: LetterState(letter: "", color: .unknown), count: count), count: 6)
        fetchAllWordsAndStartGame()
    }
    
    func fetchAllWordsAndStartGame() {
        if let count = letterCount {
            gameController.fetchAllWords(ofLength: count) { [weak self] words in
                DispatchQueue.main.async {
                    self?.allWords = Set(words)
                    self?.fetchWord()
                }
            }
        }
    }
    
    func fetchWord() {
        if let count = letterCount {
            gameController.fetchTargetWord(ofLength: count) { [weak self] word in
                DispatchQueue.main.async {
                    self?.wordModel = WordModel(word: word.joined())
                }
            }
        }
    }
    
    func handleKeyPress(_ letter: String) {
        guard currentColumn < (letterCount ?? 5) else { return }
        words[currentRow][currentColumn].letter = letter
        currentColumn += 1
    }
    
    func handleBackspace() {
        guard currentColumn > 0 else { return }
        currentColumn -= 1
        words[currentRow][currentColumn].letter = ""
    }
    
    func handleEnter() {
        guard currentColumn == letterCount, let wordModel = wordModel else { return }
        
        let guess = words[currentRow].map { $0.letter }.joined().uppercased()
        
        if !allWords.contains(guess) {
            gameStatusMessage = "La palabra no existe en el diccionario"
            showResetButton = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.clearCurrentLine()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.gameStatusMessage = ""
                }
            }
            return
        }
        
        let result = wordModel.checkGuess(guess.map { String($0) })
        words[currentRow] = result
        
        if result.allSatisfy({ $0.color == .correct }) {
            gameStatusMessage = "¡Ganaste!"
            showResetButton = true
        } else if currentRow < 5 {
            currentRow += 1
            currentColumn = 0
        } else {
            gameStatusMessage = "¡Perdiste! La palabra era \(wordModel.targetWord.map { $0.letter }.joined())"
            showResetButton = true
        }
    }
    
    private func clearCurrentLine() {
        words[currentRow] = Array(repeating: LetterState(letter: "", color: .unknown), count: letterCount ?? 5)
        currentColumn = 0
    }
        
    func resetGame() {
        words = []
        currentRow = 0
        currentColumn = 0
        gameStatusMessage = ""
        showResetButton = false
        letterCount = nil
    }
}

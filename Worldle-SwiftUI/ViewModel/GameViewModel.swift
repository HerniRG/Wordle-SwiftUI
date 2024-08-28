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
    
    private var wordModel: WordModel?
    private var allFiveLetterWords: Set<String> = []
    private let gameController = GameController()  // Definir el GameController

    init() {
        self.words = Array(repeating: Array(repeating: LetterState(letter: "", color: .unknown), count: 5), count: 6)
        fetchAllWordsAndStartGame()
    }
    
    func fetchAllWordsAndStartGame() {
        gameController.fetchAllFiveLetterWords { [weak self] words in
            DispatchQueue.main.async {
                self?.allFiveLetterWords = Set(words)
                self?.fetchWord()
            }
        }
    }
    
    func fetchWord() {
        gameController.fetchTargetWord { [weak self] word in
            DispatchQueue.main.async {
                self?.wordModel = WordModel(word: word.joined())
            }
        }
    }
    
    func handleKeyPress(_ letter: String) {
        guard currentColumn < 5 else { return }
        words[currentRow][currentColumn].letter = letter
        currentColumn += 1
    }
    
    func handleBackspace() {
        guard currentColumn > 0 else { return }
        currentColumn -= 1
        words[currentRow][currentColumn].letter = ""
    }
    
    func handleEnter() {
        guard currentColumn == 5, let wordModel = wordModel else { return }
        
        let guess = words[currentRow].map { $0.letter }.joined().uppercased()
        
        if !allFiveLetterWords.contains(guess) {
            gameStatusMessage = "La palabra no existe en el diccionario"
            showResetButton = false  // Oculta el botón de reinicio
            
            // Borra la línea actual después de un breve retraso
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.clearCurrentLine()
            }
            
            // Oculta el banner después de 3 segundos
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
            showResetButton = true  // Muestra el botón de reinicio
        } else if currentRow < 5 {
            currentRow += 1
            currentColumn = 0
        } else {
            gameStatusMessage = "¡Perdiste! La palabra era \(wordModel.targetWord.map { $0.letter }.joined())"
            showResetButton = true  // Muestra el botón de reinicio
        }
    }
    
    private func clearCurrentLine() {
        words[currentRow] = Array(repeating: LetterState(letter: "", color: .unknown), count: 5)
        currentColumn = 0
    }
    
    func resetGame() {
        words = Array(repeating: Array(repeating: LetterState(letter: "", color: .unknown), count: 5), count: 6)
        currentRow = 0
        currentColumn = 0
        gameStatusMessage = ""
        fetchWord()
    }
}

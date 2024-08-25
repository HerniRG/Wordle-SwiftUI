//
//  GameViewModel.swift
//  Worldle-SwiftUI
//
//  Created by Hernán Rodríguez on 25/8/24.
//

import SwiftUI

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var words: [[LetterState]]
    @Published var currentRow: Int = 0
    @Published var currentColumn: Int = 0
    @Published var gameStatusMessage: String = ""
    
    private var wordModel: WordModel?
    private let gameController = GameController()
    
    init() {
        self.words = Array(repeating: Array(repeating: LetterState(letter: "", color: .unknown), count: 5), count: 6)
        fetchWord()
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
        
        let guess = words[currentRow].map { $0.letter }
        let result = wordModel.checkGuess(guess)
        words[currentRow] = result
        
        if result.allSatisfy({ $0.color == .correct }) {
            gameStatusMessage = "¡Ganaste!"
        } else if currentRow < 5 {
            currentRow += 1
            currentColumn = 0
        } else {
            gameStatusMessage = "¡Perdiste! La palabra era \(wordModel.targetWord.map { $0.letter }.joined())"
        }
    }
    
    func resetGame() {
        words = Array(repeating: Array(repeating: LetterState(letter: "", color: .unknown), count: 5), count: 6)
        currentRow = 0
        currentColumn = 0
        gameStatusMessage = ""
        fetchWord()
    }
}


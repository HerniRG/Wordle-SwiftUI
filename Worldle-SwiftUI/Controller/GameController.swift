//
//  GameController.swift
//  Worldle-SwiftUI
//
//  Created by Hernán Rodríguez on 25/8/24.
//

import Foundation

class GameController {
    private let wordService = WordService()
    private(set) var targetWord: [String] = []
    private var allFiveLetterWords: [String] = []
    
    func fetchAllFiveLetterWords(completion: @escaping ([String]) -> Void) {
        if allFiveLetterWords.isEmpty {
            wordService.fetchAllFiveLetterWords { [weak self] words in
                self?.allFiveLetterWords = words
                completion(words)
            }
        } else {
            completion(allFiveLetterWords)
        }
    }
    
    func fetchTargetWord(completion: @escaping ([String]) -> Void) {
        if allFiveLetterWords.isEmpty {
            fetchAllFiveLetterWords { [weak self] words in
                if let word = words.randomElement() {
                    self?.targetWord = word.map { String($0) }
                    completion(self?.targetWord ?? [])
                } else {
                    completion([])
                }
            }
        } else {
            if let word = allFiveLetterWords.randomElement() {
                targetWord = word.map { String($0) }
                completion(targetWord)
            } else {
                completion([])
            }
        }
    }
    
    func checkWord(_ guessedWord: [String]) -> Bool {
        let normalizedGuessedWord = guessedWord.map { $0.normalized() }
        let normalizedTargetWord = targetWord.map { $0.normalized() }
        
        return normalizedGuessedWord == normalizedTargetWord
    }
}

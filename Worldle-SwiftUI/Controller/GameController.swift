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
    
    func fetchTargetWord(completion: @escaping ([String]) -> Void) {
        wordService.fetchAllFiveLetterWords { words in
            if let words = words, !words.isEmpty {
                let randomWord = words.randomElement() ?? ""
                self.targetWord = randomWord.map { String($0) }
                completion(self.targetWord)
            } else {
                completion([])
            }
        }
    }
    
    func checkWord(_ guessedWord: [String]) -> Bool {
        return guessedWord == targetWord
    }
    
    func createEmptyBoard(rows: Int = 6, columns: Int = 5) -> [[String]] {
        return Array(repeating: Array(repeating: "", count: columns), count: rows)
    }
}

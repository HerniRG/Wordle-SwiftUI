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
    private var allWords: [String] = []
    
    // Método para obtener todas las palabras de una longitud específica
    func fetchAllWords(ofLength length: Int, completion: @escaping ([String]) -> Void) {
        if allWords.isEmpty {
            wordService.fetchWords(ofLength: length) { [weak self] words in
                self?.allWords = words
                completion(words)
            }
        } else {
            completion(allWords)
        }
    }
    
    // Método para obtener una palabra objetivo de una longitud específica
    func fetchTargetWord(ofLength length: Int, completion: @escaping ([String]) -> Void) {
        if allWords.isEmpty {
            fetchAllWords(ofLength: length) { [weak self] words in
                if let word = words.randomElement() {
                    self?.targetWord = word.map { String($0) }
                    completion(self?.targetWord ?? [])
                } else {
                    completion([])
                }
            }
        } else {
            if let word = allWords.randomElement() {
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

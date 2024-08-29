//
//  WordService.swift
//  Worldle-SwiftUI
//
//  Created by Hernán Rodríguez on 25/8/24.
//

import Foundation

class WordService {
    
    private var allWords: [String] = []
    
    init() {
        loadWordsFromFile()
    }
    
    private func loadWordsFromFile() {
        if let filePath = Bundle.main.path(forResource: "listado-general", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filePath)
                allWords = contents.components(separatedBy: .newlines)
                    .map { $0.uppercased() }
                    .filter { !$0.isEmpty }
                print("Palabras cargadas: \(allWords.count)")
            } catch {
                print("Error al leer el archivo: \(error)")
            }
        } else {
            print("Archivo no encontrado")
        }
    }

    
    func fetchWords(ofLength length: Int, completion: @escaping ([String]) -> Void) {
        let filteredWords = allWords.filter { $0.count == length }
        completion(filteredWords)
    }
    
    func fetchRandomWord(ofLength length: Int, completion: @escaping (String?) -> Void) {
        let wordsOfLength = allWords.filter { $0.count == length }
        completion(wordsOfLength.randomElement())
    }
    
    func isWordValid(_ word: String) -> Bool {
        return allWords.contains(word.uppercased())
    }
}

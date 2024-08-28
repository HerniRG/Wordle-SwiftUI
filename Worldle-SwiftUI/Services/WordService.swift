//
//  WordService.swift
//  Worldle-SwiftUI
//
//  Created by Hernán Rodríguez on 25/8/24.
//

import Foundation

class WordService {
    
    func fetchAllFiveLetterWords(completion: @escaping ([String]) -> Void) {
        let letters = "abcdefghijklmnopqrstuvwxyz".map { String($0) }
        var allWords: Set<String> = []
        let dispatchGroup = DispatchGroup()

        for letter in letters {
            dispatchGroup.enter()
            let urlString = "https://api.datamuse.com/words?sp=\(letter)????&v=es&max=1000"
            guard let url = URL(string: urlString) else {
                dispatchGroup.leave()
                continue
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                defer { dispatchGroup.leave() }

                if let data = data,
                   let wordList = try? JSONDecoder().decode([Word].self, from: data) {
                    let words = wordList.map { $0.word.uppercased() }
                    allWords.formUnion(words)
                }
            }.resume()
        }

        dispatchGroup.notify(queue: .main) {
            completion(Array(allWords))
        }
    }
    
    private struct Word: Decodable {
        let word: String
    }
}

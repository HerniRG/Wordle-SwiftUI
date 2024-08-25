//
//  WordService.swift
//  Worldle-SwiftUI
//
//  Created by Hernán Rodríguez on 25/8/24.
//

import Foundation

class WordService {
    
    func fetchAllFiveLetterWords(completion: @escaping ([String]?) -> Void) {
        let url = URL(string: "https://api.datamuse.com/words?sp=?????&max=1000&v=es")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
               let wordList = try? JSONDecoder().decode([Word].self, from: data) {
                let words = wordList.map { $0.word.uppercased() }
                completion(words)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    private struct Word: Decodable {
        let word: String
    }
}

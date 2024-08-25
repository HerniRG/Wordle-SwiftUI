//
//  Model.swift
//  Worldle-SwiftUI
//
//  Created by Hernán Rodríguez on 25/8/24.
//

import Foundation

// Representa el estado de una letra en la cuadrícula
struct LetterState {
    var letter: String
    var color: LetterColor
}

// Enum para los posibles colores de una letra
enum LetterColor {
    case correct   // Verde: Letra correcta en la posición correcta
    case present   // Amarillo: Letra correcta pero en la posición incorrecta
    case absent    // Gris: Letra incorrecta
    case unknown   // Sin definir: No evaluada aún
}

// Modelo que representa la palabra objetivo y la lógica de validación
struct WordModel {
    let targetWord: [LetterState]
    
    init(word: String) {
        self.targetWord = word.map { LetterState(letter: String($0), color: .unknown) }
    }
    
    func checkGuess(_ guess: [String]) -> [LetterState] {
        var result = [LetterState]()
        var remainingTargetLetters = targetWord
        
        // Primero, identificar las letras correctas (verdes)
        for (index, letter) in guess.enumerated() {
            let normalizedGuess = letter.normalized
            let normalizedTarget = targetWord[index].letter.normalized
            
            if normalizedGuess == normalizedTarget {
                result.append(LetterState(letter: letter, color: .correct))
                remainingTargetLetters[index].color = .correct
            } else {
                result.append(LetterState(letter: letter, color: .unknown))
            }
        }
        
        // Luego, identificar las letras presentes pero en la posición incorrecta (amarillo)
        for i in 0..<result.count {
            if result[i].color == .unknown {
                if let targetIndex = remainingTargetLetters.firstIndex(where: {
                    $0.letter.normalized == result[i].letter.normalized &&
                    $0.color != .correct
                }) {
                    result[i].color = .present
                    remainingTargetLetters[targetIndex].color = .present
                } else {
                    result[i].color = .absent
                }
            }
        }
        
        return result
    }
}

// Extensión para normalizar las letras eliminando tildes y diacríticos
extension String {
    var normalized: String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
}

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
import Foundation

struct WordModel {
    let targetWord: [LetterState]
    
    init(word: String) {
        self.targetWord = word.map { LetterState(letter: String($0), color: .unknown) }
    }
    
    func checkGuess(_ guess: [String]) -> [LetterState] {
        var result = [LetterState]()
        var remainingTargetLetters = targetWord
        var letterCount: [String: Int] = [:]
        
        // Contar la cantidad de letras en la palabra objetivo
        for letterState in targetWord {
            let letter = letterState.letter.normalized
            letterCount[letter, default: 0] += 1
        }
        
        // Primero, identificar las letras correctas (verdes)
        for (index, letter) in guess.enumerated() {
            let normalizedGuess = letter.normalized
            let normalizedTarget = targetWord[index].letter.normalized
            
            if normalizedGuess == normalizedTarget {
                result.append(LetterState(letter: letter, color: .correct))
                remainingTargetLetters[index].color = .correct
                letterCount[normalizedGuess]? -= 1  // Disminuir el conteo de esa letra
            } else {
                result.append(LetterState(letter: letter, color: .unknown))
            }
        }
        
        // Luego, identificar las letras presentes pero en la posición incorrecta (amarillo)
        for i in 0..<result.count {
            if result[i].color == .unknown {
                let normalizedGuess = result[i].letter.normalized
                if let targetIndex = remainingTargetLetters.firstIndex(where: {
                    $0.letter.normalized == normalizedGuess && $0.color != .correct
                }), letterCount[normalizedGuess, default: 0] > 0 {
                    result[i].color = .present
                    remainingTargetLetters[targetIndex].color = .present
                    letterCount[normalizedGuess]? -= 1  // Disminuir el conteo de esa letra
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

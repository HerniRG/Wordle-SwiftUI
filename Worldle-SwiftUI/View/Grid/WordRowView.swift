//
//  WordRowView.swift
//  Worldle-SwiftUI
//
//  Created by Hernán Rodríguez on 25/8/24.
//

import SwiftUI

struct WordRowView: View {
    var letters: [LetterState]
    var isActive: Bool
    var showColors: Bool
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<letters.count, id: \.self) { index in
                LetterCellView(
                    letter: letters[index].letter,
                    backgroundColor: showColors ? colorForState(letters[index].color) : .gray
                )
                .scaleEffect(isActive ? 1.1 : 1.0)
            }
        }
    }
    
    private func colorForState(_ color: LetterColor) -> Color {
        switch color {
        case .correct:
            return .green
        case .present:
            return .yellow
        case .absent:
            return .gray
        case .unknown:
            return .gray
        }
    }
}


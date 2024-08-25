//
//  WordGridView.swift
//  Worldle-SwiftUI
//
//  Created by Hernán Rodríguez on 25/8/24.
//
import SwiftUI

import SwiftUI

struct WordGridView: View {
    @EnvironmentObject var viewModel: GameViewModel
    var animateRow: Bool
    var showColors: [Bool]
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(0..<viewModel.words.count, id: \.self) { row in
                WordRowView(
                    letters: viewModel.words[row],
                    isActive: animateRow && row == viewModel.currentRow - 1,
                    showColors: showColors[row]
                )
                .animation(.easeInOut(duration: 0.3), value: showColors[row])
            }
        }
    }
}




#Preview {
    WordGridView(animateRow: true, showColors: Array(repeating: false, count: 6))
        .environmentObject(GameViewModel())
}

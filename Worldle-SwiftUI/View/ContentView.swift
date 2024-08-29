//
//  ContentView.swift
//  Worldle-SwiftUI
//
//  Created by Hernán Rodríguez on 25/8/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()
    @State private var animateRow: Bool = false
    @State private var showColors: [Bool] = []
    
    var body: some View {
        VStack(spacing: 20) {
            if let _ = viewModel.letterCount {
                // Mostrar el juego cuando se selecciona el número de letras
                GameStatusBannerView()
                
                WordGridView(animateRow: animateRow, showColors: showColors)
                    .environmentObject(viewModel)
                
                KeyboardView()
                    .environmentObject(viewModel)
            } else {
                // Mostrar la pantalla de selección de letras
                LetterCountSelectionView { selectedLetterCount in
                    viewModel.startGame(withLetterCount: selectedLetterCount)
                    showColors = Array(repeating: false, count: 6)
                }
            }
        }
        .onAppear {
            if viewModel.letterCount != nil {
                viewModel.fetchWord()
            }
        }
        .onChange(of: viewModel.currentRow) { oldRow, newRow in
            handleEnter()
        }
        .environmentObject(viewModel)
    }
    
    private func handleEnter() {
        guard viewModel.currentRow > 0 else { return }

        withAnimation {
            showColors[viewModel.currentRow - 1] = true
            animateRow = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                animateRow = false
            }
        }
    }
}

#Preview {
    ContentView()
}

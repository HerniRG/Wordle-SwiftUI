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
    @State private var showColors: [Bool] = Array(repeating: false, count: 6)
    
    var body: some View {
        VStack(spacing: 20) {
            GameStatusBannerView()
            
            WordGridView(animateRow: animateRow, showColors: showColors)
            
            KeyboardView()
        }
        .onAppear {
            viewModel.fetchWord()
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

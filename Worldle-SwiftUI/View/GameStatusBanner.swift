//
//  GameStatusBanner.swift
//  Worldle-SwiftUI
//
//  Created by Hernán Rodríguez on 25/8/24.
//

import SwiftUI

struct GameStatusBanner: View {
    @EnvironmentObject var viewModel: GameViewModel
    
    var body: some View {
        ZStack {
            if !viewModel.gameStatusMessage.isEmpty {
                Color.blue
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .cornerRadius(10)
                    .transition(.opacity)
                
                HStack {
                    Text(viewModel.gameStatusMessage)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.resetGame()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .padding(.horizontal)
            }
        }
        .frame(height: 100)  // Mantener el tamaño fijo del banner
        .animation(.easeInOut, value: viewModel.gameStatusMessage)
    }
}

#Preview {
    GameStatusBanner()
        .environmentObject(GameViewModel())
}

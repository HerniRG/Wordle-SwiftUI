//
//  LetterCountSelectionView.swift
//  Worldle-SwiftUI
//
//  Created by Hernán Rodríguez on 28/8/24.
//

import SwiftUI

struct LetterCountSelectionView: View {
    var onSelection: (Int) -> Void
    @State private var logoScale: CGFloat = 0.5  // Estado para controlar la escala de la imagen
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            Spacer()
            
            Image("Wordle_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .scaleEffect(logoScale)  
                .onAppear {
                    withAnimation(.interpolatingSpring(stiffness: 50, damping: 5)) {
                        logoScale = 1.0
                    }
                }
            
            Spacer()
            
            Text("Selecciona la cantidad de letras")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            
            HStack(spacing: 20) {
                Button("4 Letras") {
                    onSelection(4)
                }
                .font(.title2)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("5 Letras") {
                    onSelection(5)
                }
                .font(.title2)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("6 Letras") {
                    onSelection(6)
                }
                .font(.title2)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    LetterCountSelectionView { _ in }
}

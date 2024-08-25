//
//  KeyboardView.swift
//  Worldle-SwiftUI
//
//  Created by Hernán Rodríguez on 25/8/24.
//

import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject var viewModel: GameViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(["QWERTYUIOP", "ASDFGHJKLÑ", "ZXCVBNM"], id: \.self) { row in  
                HStack(spacing: 5) {
                    ForEach(row.map { String($0) }, id: \.self) { letter in
                        Button(action: {
                            viewModel.handleKeyPress(letter)
                        }) {
                            Text(letter)
                                .font(.title2)
                                .frame(width: 35, height: 50)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
            }
            HStack(spacing: 10) {
                Button(action: viewModel.handleBackspace) {
                    Text("⌫")
                        .font(.title2)
                        .frame(width: 70, height: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Button(action: {
                    viewModel.handleEnter()
                }) {
                    Text("Enter")
                        .font(.title2)
                        .frame(width: 100, height: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    KeyboardView()
        .environmentObject(GameViewModel())
}

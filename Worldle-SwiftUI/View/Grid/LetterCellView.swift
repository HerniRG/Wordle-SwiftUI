//
//  LetterCellView.swift
//  Worldle-SwiftUI
//
//  Created by Hernán Rodríguez on 25/8/24.
//

import SwiftUI

struct LetterCellView: View {
    var letter: String
    var backgroundColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(backgroundColor)
                .frame(width: 50, height: 50)
            
            Text(letter)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    LetterCellView(letter: "A", backgroundColor: .gray)
}

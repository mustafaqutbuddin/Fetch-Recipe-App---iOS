//
//  NoImagePlaceholderView.swift
//  Fetch Recipe Test
//
//  Created by Mustafa Qutbuddin on 2024-10-06.
//

import SwiftUI

struct NoImagePlaceholderView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.gray.opacity(0.3))
            .frame(height: 150)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 4)
            .overlay {
                HStack {
                    Image(systemName: "bolt")
                    Text("no image to display")
                        .minimumScaleFactor(0.5)
                }
            }
    }
}

#Preview {
    NoImagePlaceholderView()
}

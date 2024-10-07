//
//  RecipeCardView.swift
//  Fetch Recipe Test
//
//  Created by Mustafa Qutbuddin on 2024-10-06.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipeCardView: View {
    var recipe: Recipe
    @State private var useSmallImageOnFailure = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            WebImage(url: URL(string: useSmallImageOnFailure ? recipe.imageURLSmall : recipe.imageURLLarge)) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .clipped()
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 4)
            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.3))
                    .frame(height: 150)
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 4)
            }
            .onFailure { _ in
                useSmallImageOnFailure = true
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            
            Text(recipe.name)
                .font(.headline)
                .lineLimit(2)
                .minimumScaleFactor(0.75)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

#Preview {
    RecipeCardView(recipe: Recipe(id: UUID().uuidString,
                                  cuisine: "British",
                                  name: "Apple & Blackberry Crumble",
                                  imageURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                                  imageURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg"))
}

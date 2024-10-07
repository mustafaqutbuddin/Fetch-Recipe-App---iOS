//
//  Recipe.swift
//  Fetch Recipe Test
//
//  Created by Mustafa Qutbuddin on 2024-10-06.
//

import Foundation

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

struct Recipe: Identifiable, Codable, Equatable {
    var id: String
    var cuisine: String
    var name: String
    var imageURLLarge: String
    var imageURLSmall: String
    var youtubeURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine, name
        case imageURLLarge = "photo_url_large"
        case imageURLSmall = "photo_url_small"
        case youtubeURL = "youtube_url"
    }
}

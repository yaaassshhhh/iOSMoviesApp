//
//  Movies.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 08/07/25.
//

import Foundation

struct Movie: Decodable {
    var title: String
    var ageRating: Bool
    var rating : Double
    var posterURL: String
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case ageRating = "adult"
        case rating = "vote_average"
        case posterURL = "poster_path"
        case id = "id"
    }
}

//
//  Movies.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 08/07/25.
//

import Foundation

struct Movie: Decodable {
    var title: String
    var releaseDate : String
    var posterURL: String
    var description: String
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case releaseDate = "release_date"
        case posterURL = "poster_path"
        case id
        case description = "overview"
    }
}

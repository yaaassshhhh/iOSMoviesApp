//
//  Info.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 16/07/25.
//

import Foundation
struct Info: Decodable {
    var movieName: String?
    var description: String?
    var rating: Double?
    var votes: Int?
    var genres: [Genre]
    var posterPath: String?
    
    enum CodingKeys : String, CodingKey {
        case movieName = "original_title"
        case description = "overview"
        case rating = "vote_average"
        case votes = "vote_count"
        case posterPath = "poster_path"
        case genres
    }
}


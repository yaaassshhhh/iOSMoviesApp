//
//  Info.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 16/07/25.
//

import Foundation
struct Info: Decodable {
    var movieName: String
    var description: String
    var rating: Double
    var votes: Int
    var genres: [Genre]
    var posterPath: String
    
    enum CodingKeys : String, CodingKey {
        case movieName = "original_title"
        case description = "overview"
        case rating = "vote_average"
        case votes = "vote_count"
        case posterPath = "poster_path"
        case genres
    }
}
extension Info {
    static func resource(id movie_id : Int) -> Resource<Info> {
        guard let movieListURL = URL(string : "https://api.themoviedb.org/3/movie/\(movie_id)") else {
            fatalError("Invalid URL")
        }
        return Resource<Info>(url : movieListURL, parse : { data in
            let decoded = try? JSONDecoder().decode(Info.self, from: data)
            return decoded
        })
    }
}

//
//  CreditsResponse.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 11/07/25.
//

import Foundation

struct CreditsResponse : Decodable {
    var results : [Cast]
    
    enum codingKeys : String, CodingKey {
        case results = "cast"
    }
}

extension CreditsResponse {
    static func resource(id movie_id : Int) -> Resource<CreditsResponse> {
        guard let creditsURL = URL(string : "https://api.themoviedb.org/3/movie/\(movie_id)/credits") else {
            fatalError("Invalid URL")
        }
        return Resource<CreditsResponse>(url : creditsURL, parse : { data in
            let decoded = try? JSONDecoder().decode(CreditsResponse.self, from: data)
            return decoded
        })
    }
}

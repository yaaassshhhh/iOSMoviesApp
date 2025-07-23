//
//  CreditsResponse.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 11/07/25.
//

import Foundation

struct CreditsResponse : Decodable {
    var results : [Cast]
    
    enum CodingKeys : String, CodingKey {
        case results = "cast"
    }
}

extension CreditsResponse {
    static func resource(id movie_id : Int) -> Result<Resource<CreditsResponse>, NetworkError> {
        guard let creditsURL = URL(string : "https://api.themoviedb.org/3/movie/\(movie_id)/credits") else {
            return .failure(.urlError)
        }
        let resource = Resource<CreditsResponse>(url : creditsURL, parse : { data in
            let decoded = try? JSONDecoder().decode(CreditsResponse.self, from: data)
            return decoded
        })
        return .success(resource)
    }
}

//
//  ReviewsResponse.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 11/07/25.
//

import Foundation

struct ReviewsResponse : Decodable {
    var results : [Review]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

extension ReviewsResponse {
    static func resource(id movie_id: Int) -> Result<Resource<ReviewsResponse>, NetworkError> {
        guard let reviewURL = URL(string : "https://api.themoviedb.org/3/movie/\(movie_id)/reviews") else {
            return .failure(.urlError)
        }
        let resource = Resource<ReviewsResponse>(url : reviewURL, parse : { data in
            let decoded = try? JSONDecoder().decode(ReviewsResponse.self, from: data)
            return decoded
        })
        return .success(resource)
    }
}

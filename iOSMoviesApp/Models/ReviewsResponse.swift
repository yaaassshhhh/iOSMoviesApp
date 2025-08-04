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

//
//  SimilarResponse.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 29/07/25.
//

import Foundation

struct SimilarResponse : Decodable {
    var results : [Similar]
    
    enum CodingKeys : String, CodingKey {
        case results = "results"
    }
}

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

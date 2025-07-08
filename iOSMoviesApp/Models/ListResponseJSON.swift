//
//  ListResponseJSON.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 08/07/25.
//

import Foundation

struct ListResponseJSON : Decodable {
    var results : [Movie]
    
    enum codingKeys : String, CodingKey {
        case results = "results"
    }
}

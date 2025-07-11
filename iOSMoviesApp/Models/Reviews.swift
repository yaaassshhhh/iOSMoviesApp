//
//  Reviews.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 11/07/25.
//

struct Review : Decodable{
    var name: String
    var comment: String
    
    enum CodingKeys : String, CodingKey {
        case name = "author"
        case comment = "content"
    }
}

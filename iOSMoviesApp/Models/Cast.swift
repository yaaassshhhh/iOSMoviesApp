//
//  Cast.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 11/07/25.
//

struct Cast: Decodable {
    var realName: String
    var fictionalName : String
    var posterPath: String?
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case realName = "original_name"
        case fictionalName = "character"
        case posterPath  = "profile_path"
        case id
    }
}


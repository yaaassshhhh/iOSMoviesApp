//
//  Genre.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 16/07/25.
//
import Foundation

struct Genre : Decodable {
    var type : String
    
    enum CodingKeys : String, CodingKey {
        case type = "name"
    }
}

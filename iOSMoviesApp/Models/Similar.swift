//
//  Similar.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 29/07/25.
//


struct Similar: Decodable {
    var title: String?
    var posterPath: String?
    var id: Int?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case posterPath  = "poster_path"
        case id
    }
}


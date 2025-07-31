//
//  RecentSearchViewModel.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 31/07/25.
//

import Foundation

class RecentSearchViewModel: NSObject {
    let id: Int
    let title: String
    let posterPath: String
    
    init(id: Int, title: String, posterPath: String) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
    }
}

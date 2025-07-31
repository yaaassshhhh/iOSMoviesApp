//
//  RecentSearchViewModel.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 31/07/25.
//

import Foundation

class RecentSearchViewModel {
    let id: Int
    let title: String
    
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getId() -> Int {
        return id
    }
    
}

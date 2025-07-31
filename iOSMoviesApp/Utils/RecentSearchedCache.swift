//
//  RecentSearchedCache.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 31/07/25.
//

import Foundation
final class RecentSearchedCache {
    
    static let searched = RecentSearchedCache()
    private let maxLimit = 5
    
    private var recentMovieIDs: [Int] = []
    private let cache = NSCache<NSNumber, MovieViewModel>()
    
    private init() {
        cache.countLimit = maxLimit
    }
    
    func addRecentMovie(movie: MovieViewModel) {
        
        let key = NSNumber(value: movie.id)
        if let index = recentMovieIDs.firstIndex(of: movie.id) {
            recentMovieIDs.remove(at: index)
        }
        
        recentMovieIDs.insert(movie.id, at: 0)
        
        cache.setObject(movie, forKey: key)
        
        if recentMovieIDs.count > maxLimit {
            let removedID = recentMovieIDs.removeLast()
            cache.removeObject(forKey: NSNumber(value: removedID))
        }
    }
    
    func getRecentMovies() -> [MovieViewModel] {
        return recentMovieIDs.compactMap { cache.object(forKey: NSNumber(value: $0)) }
    }
    
    func clear() {
        recentMovieIDs.removeAll()
        cache.removeAllObjects()
    }
}

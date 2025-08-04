//
//  RecentSearchedCache.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 31/07/25.
//

import UIKit

final class RecentSearchedCache {
    
    static let searched = RecentSearchedCache()
    private let cache = NSCache<NSNumber, MovieViewModel>()
    private let maxLimit = 5
    private var movieIds: [Int] = [] 
    
    private init() {
        cache.countLimit = maxLimit
        cache.name = "RecentMoviesCache"
    }
    
    func addRecentMovie(movie: MovieViewModel) {
        let movieId = NSNumber(value: movie.id)
        
        if let existingIndex = movieIds.firstIndex(of: movie.id) {
            movieIds.remove(at: existingIndex)
        }
        
        movieIds.insert(movie.id, at: 0)
        
        if movieIds.count > maxLimit {
            let removedId = movieIds.removeLast()
            cache.removeObject(forKey: NSNumber(value: removedId))
        }
        
        cache.setObject(movie, forKey: movieId)
    }
    
    func getRecentMovies() -> [MovieViewModel] {
        var recentMovies: [MovieViewModel] = []
        
        for movieId in movieIds {
            if let movie = cache.object(forKey: NSNumber(value: movieId)) {
                recentMovies.append(movie)
            }
        }
        return recentMovies
    }
    
    func clear() {
        cache.removeAllObjects()
        movieIds.removeAll()
    }
}

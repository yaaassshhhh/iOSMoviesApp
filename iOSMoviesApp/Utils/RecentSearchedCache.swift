//
//  RecentSearchedCache.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 31/07/25.
//

import Foundation
final class RecentSearchManager {
    static let shared = RecentSearchManager()
    private let maxLimit = 5
    private var recentMovieIDs: [Int] = [] // To preserve FILO order
    private let cache = NSCache<NSNumber, MovieViewModel>()
    private init() {
        // Optional: set memory limits on cache if needed
        cache.countLimit = maxLimit
    }
    func add(movie: MovieViewModel) {
        let key = NSNumber(value: movie.id)
        // Remove existing entry if already present
        if let index = recentMovieIDs.firstIndex(of: movie.id) {
            recentMovieIDs.remove(at: index)
        }
        // Insert at top
        recentMovieIDs.insert(movie.id, at: 0)
        cache.setObject(movie, forKey: key)
        // Maintain max limit
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

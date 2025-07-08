//
//  DiscoveryViewModel.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 08/07/25.
//

import Foundation

class DiscoveryViewModel {
    
    var movies: [Movie] = []
    var filteredMovies : [Movie] = []
    var featuredMovies: [Movie] {
        return Array(movies.prefix(4))
    }

    func fetchMovies(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://example.com/api/movies") else {
            print("Invalid URL")
            return
        }

        let resource = Resource<[Movie]>(
            url: url,
            parse: { data in
                return try? JSONDecoder().decode([Movie].self, from: data)
            }
        )

        WebService().load(resource: resource) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                completion()
            case .failure(let error):
                print("Failed to fetch movies:", error)
                completion()
            }
        }
    }
    
    func filterMovies(query: String) {
        if query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter { $0.title.lowercased().contains(query.lowercased()) }
        }
    }

}

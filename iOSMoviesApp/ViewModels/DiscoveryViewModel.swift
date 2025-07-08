//
//  DiscoveryViewModel.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 08/07/25.
//

import Foundation

class DiscoveryViewModel {
    
    var movies: [Movie] = []

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
}

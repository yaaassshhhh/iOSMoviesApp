//
//  SimilarDetailsViewModel.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 29/07/25.
//

import Foundation

struct SimilarDetailsViewModel {
    
    var similarViewModels: [SimilarViewModel]
    init(similarViewModels: [SimilarViewModel]) {
        self.similarViewModels = similarViewModels
    }
}

extension SimilarDetailsViewModel {
    
    func getSimilarViewModel(at index : Int) -> SimilarViewModel {
        return self.similarViewModels[index]
    }
    
    func numberOfSimilar() -> Int {
        return self.similarViewModels.count
    }
}

extension SimilarResponse {
    static func resource(id movie_id : Int) -> Result<Resource<SimilarResponse>, NetworkError> {
        guard let similarURL = URL(string : "https://api.themoviedb.org/3/movie/\(movie_id)/similar") else {
            return .failure(.urlError)
        }
        let resource = Resource<SimilarResponse>(url : similarURL, parse : { data in
            let decoded = try? JSONDecoder().decode(SimilarResponse.self, from: data)
            return decoded
        })
        return .success(resource)
    }
}

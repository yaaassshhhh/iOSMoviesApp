//
//  CastDetailsViewModel.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 16/07/25.
//
import Foundation

struct CastDetailsViewModel {
    
    var castViewModels: [CastViewModel]
    init(castViewModels: [CastViewModel]) {
        self.castViewModels = castViewModels
    }
}

extension CastDetailsViewModel {
    
    func getCastViewModel(at index : Int) -> CastViewModel {
        return self.castViewModels[index]
    }
    
    func numberOfCasts() -> Int {
        return self.castViewModels.count
    }
}

extension CreditsResponse {
    static func resource(id movie_id : Int) -> Result<Resource<CreditsResponse>, NetworkError> {
        guard let creditsURL = URL(string : "https://api.themoviedb.org/3/movie/\(movie_id)/credits") else {
            return .failure(.urlError)
        }
        let resource = Resource<CreditsResponse>(url : creditsURL, parse : { data in
            let decoded = try? JSONDecoder().decode(CreditsResponse.self, from: data)
            return decoded
        })
        return .success(resource)
    }
}

//
//  ReviewDetailsViewModel.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 28/07/25.
//

import Foundation


struct ReviewDetailsViewModel {
    
    var reviewViewModels: [ReviewViewModel]
    init(reviewViewModels: [ReviewViewModel]){
        self.reviewViewModels = reviewViewModels
    }
}

extension ReviewDetailsViewModel {
    
    func numberOfReviews() -> Int {
        return reviewViewModels.count
    }
    
    func getReviewViewModel(at index: Int) -> ReviewViewModel {
        return self.reviewViewModels[index]
    }
}

extension ReviewsResponse {
    static func resource(id movie_id: Int) -> Result<Resource<ReviewsResponse>, NetworkError> {
        guard let reviewURL = URL(string : "https://api.themoviedb.org/3/movie/\(movie_id)/reviews") else {
            return .failure(.urlError)
        }
        let resource = Resource<ReviewsResponse>(url : reviewURL, parse : { data in
            let decoded = try? JSONDecoder().decode(ReviewsResponse.self, from: data)
            return decoded
        })
        return .success(resource)
    }
}

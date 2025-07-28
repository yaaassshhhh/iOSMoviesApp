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

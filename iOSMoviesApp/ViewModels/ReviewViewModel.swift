//
//  ReviewViewModel.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 11/07/25.
//

import Foundation

struct ReviewViewModel {
    
    var review: Review
    init(review: Review) {
        self.review = review
    }
}

extension ReviewViewModel: Identifiable {
    
    var id: Int {
        return self.review.id
    }
    
    var name : String {
        return self.review.name
    }
    
    var comment : String {
        return self.review.comment
    }
}

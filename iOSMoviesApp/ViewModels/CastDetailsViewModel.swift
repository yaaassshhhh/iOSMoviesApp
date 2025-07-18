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

//
//  SimilarViewModel.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 29/07/25.
//

import Foundation

struct SimilarViewModel {
    
    var similar : Similar
    var posterBaseURL: String = "https://image.tmdb.org/t/p/w185"
    var delegate : SimilarCollectionViewCellDelegate?
    init(similar : Similar){
        self.similar = similar
    }
}

extension SimilarViewModel : Identifiable {
    
    var id : Int {
        guard let id : Int = self.similar.id else { return 0 }
        return id
    }
    
    var posterPath : String {
        guard let imageURLString: String = self.similar.posterPath else { return "" }
        return self.posterBaseURL + imageURLString
    }
    
    var title : String {
        guard let title : String = self.similar.title else { return "" }
        return title
    }
    
    mutating func loadCastImage(delegate: SimilarCollectionViewCellDelegate?) {
        
        guard let delegate: SimilarCollectionViewCellDelegate = delegate else { return }
        self.delegate = delegate
        guard let delegate: SimilarCollectionViewCellDelegate = self.delegate else { return }
        
        if self.similar.posterPath == nil {
                DispatchQueue.main.async {
                    delegate.updateProfilePicFromPlaceholder(named: "tarangPic")
                }
           return
        }
        guard let imageURL: URL = URL(string: self.posterPath) else { return }
        let cacheKey: NSString = NSString(string: self.posterPath)
        
        if let cachedImage = ImageCache.shared.object(forKey: cacheKey) {
            DispatchQueue.main.async {
                delegate.updatePosterFromCache(with: cachedImage)
            }
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
            delegate.updatePoster(with: imageData, cacheKey: cacheKey)
        }
    }
}

//
//  CastViewModel.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 11/07/25.
//
import Foundation

struct CastViewModel {
    
    var cast : Cast
    var posterBaseURL: String = "https://image.tmdb.org/t/p/w185"
    var delegate : CastCollectionViewCellDelegate?
    init(cast : Cast){
        self.cast = cast
    }
}

extension CastViewModel : Identifiable {
    
    var id : Int {
        guard let id : Int = self.cast.id else { return 0 }
        return id
    }
    
    var posterPath : String {
        guard let imageURLString: String = self.cast.posterPath else { return "" }
        return self.posterBaseURL + imageURLString
    }
    
    var realName : String {
        guard let realName : String = self.cast.realName else { return "" }
        return realName
    }
    
    var fictionalName : String {
        guard let fictionalName : String = self.cast.fictionalName else { return "" }
        return fictionalName
    }
    
    mutating func loadCastImage(delegate: CastCollectionViewCellDelegate?) {
        
        guard let delegate: CastCollectionViewCellDelegate = delegate else { return }
        self.delegate = delegate
        guard let delegate: CastCollectionViewCellDelegate = self.delegate else { return }
        
        if self.cast.posterPath == nil {
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

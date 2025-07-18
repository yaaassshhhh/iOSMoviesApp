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
        return self.cast.id
    }
    var posterPath : String {
        guard let imageURLString = self.cast.posterPath else { return "" }
        return self.posterBaseURL + imageURLString
    }
    var realName : String {
        return self.cast.realName
    }
    var fictionalName : String {
        return self.cast.fictionalName
    }
    mutating func loadCastImage(delegate: CastCollectionViewCellDelegate?) {
        guard let delegate = delegate else { return }
        self.delegate = delegate
        guard let delegate = self.delegate else { return }
        if self.cast.posterPath == nil {
                DispatchQueue.main.async {
                    delegate.updateProfilePicFromPlaceholder(named: "tarangPic")
                }
           return
        }
        guard let imageURL = URL(string: self.posterPath) else { return }
        let cacheKey = NSString(string: self.posterPath)
        if let cachedImage = ImageCache.shared.object(forKey: cacheKey) {
            DispatchQueue.main.async {
                delegate.updateProfilePicFromCache(with: cachedImage)
            }
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            delegate.updateProfilePic(with: imageData, cacheKey: cacheKey)
        }
    }
}

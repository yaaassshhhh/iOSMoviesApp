//
//  InfoViewModel.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 16/07/25.
//

import Foundation

struct InfoViewModel {
    var info : Info
    var posterBaseURL : String = "https://image.tmdb.org/t/p/w342"
    var delegate : InfoTableViewCellDelegate?
    init(info : Info) {
        self.info = info
    }
}
extension InfoViewModel {
    var movieName : String {
        return self.info.movieName
    }
    var description : String {
        return self.info.description
    }
    var rating : String {
        return "\(self.info.rating)/10"
    }
    var votes : String {
        return "\(self.info.votes) votes"
    }
    var genres : String {
        var strGenres : [String] = []
        for genre in self.info.genres {
            strGenres.append(genre.type)
        }
        let genreSentence = strGenres.joined(separator: ", ")
        return genreSentence
    }
    var posterPath : String {
        return self.posterBaseURL + self.info.posterPath
    }
    mutating func loadMoviePoster(delegate : InfoTableViewCellDelegate?) {
        guard let delegate = delegate else { return }
        self.delegate = delegate
        guard let delegate = self.delegate else { return }
        guard let imageURL = URL(string : self.posterPath) else { return }
        let cacheKey = NSString(string : self.posterPath)
        if let cachedImage = ImageCache.shared.object(forKey: cacheKey) {
            DispatchQueue.main.async {
                delegate.updatePosterFromCache(with: cachedImage)
            }
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            delegate.updatePoster(with: imageData, cacheKey: cacheKey)
        }
    }
}

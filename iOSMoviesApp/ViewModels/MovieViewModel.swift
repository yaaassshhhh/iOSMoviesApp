//
//  MovieViewModel.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 11/07/25.
//
import Foundation

struct MovieViewModel {
    var movie : Movie
    var posterBaseURL: String = "https://image.tmdb.org/t/p/w342"
    var delegate : MovieCardTableViewCellDelegate?
    init(movie: Movie) {
        self.movie = movie
    }
}
extension MovieViewModel : Identifiable {
    var id : Int {
        return self.movie.id
    }
    var title : String {
        return self.movie.title
    }
    var releaseDate : String {
        return self.movie.releaseDate
    }
    var description : String {
        return self.movie.description
    }
    var posterPath : String {
        return self.posterBaseURL + self.movie.posterPath
    }
    func loadImage(delegate: MovieCardTableViewCellDelegate?) {
        guard let delegate = delegate else { return }
        guard let imageURL = URL(string: self.posterPath) else { return }
        let cacheKey = NSString(string: self.posterPath)
        
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

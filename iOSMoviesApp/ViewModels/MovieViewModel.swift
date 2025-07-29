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
        guard let id: Int = self.movie.id else {
            return 0
        }
        return id
    }
    
    var title : String {
        guard let title: String = self.movie.title else {
            return ""
        }
        return title
    }
    
    var releaseDate : String {
        guard let releaseDate: String = self.movie.releaseDate else {
            return ""
        }
        return releaseDate
    }
    
    var description : String {
        guard let description: String = self.movie.description else {
            return ""
        }
        return description
    }
    
    var posterPath : String {
        guard let posterPath: String = self.movie.posterPath else {
            return ""
        }
        return self.posterBaseURL + posterPath
    }
    
    mutating func loadImage(delegate: MovieCardTableViewCellDelegate?) {
        
        guard let delegate: MovieCardTableViewCellDelegate = delegate else { return }
        self.delegate = delegate
        guard let delegate: MovieCardTableViewCellDelegate = self.delegate else { return }
        
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

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
    var delegate : MovieCardTableViewCellDelegate?
    init(info : Info) {
        self.info = info
    }
}
extension InfoViewModel {
    
    var movieName : String {
        guard let movieName: String = self.info.movieName else {
            return ""
        }
        return movieName
    }
    
    var description : String {
        guard let description: String = self.info.description else {
            return ""
        }
        return description
    }
    
    var rating : String {
        guard let rating: Double = self.info.rating else {
            return ""
        }
        let ratingStr : String = String(format: "%.1f", rating)
        return "\(ratingStr)/10"
    }
    
    var votes : String {
        guard let votes: Int = self.info.votes else {
            return ""
        }
        return "\(votes) votes"
    }
    
    var genres : String {
        var strGenres : [String] = []
        for genre in self.info.genres {
            guard let type : String = genre.type else {
                return strGenres.joined(separator: ", ")
            }
            strGenres.append(type)
        }
        let genreSentence: String = strGenres.joined(separator: ", ")
        return genreSentence
    }
    
    var posterPath : String {
        guard let posterPath: String = self.info.posterPath else {
            return ""
        }
        return self.posterBaseURL + posterPath
    }
    
    mutating func loadMoviePoster(delegate : MovieCardTableViewCellDelegate?) {
        
        guard let delegate: MovieCardTableViewCellDelegate = delegate else { return }
        self.delegate = delegate
        guard let delegate: MovieCardTableViewCellDelegate = self.delegate else { return }
        
        guard let imageURL: URL = URL(string : self.posterPath) else { return }
        let cacheKey: NSString = NSString(string : self.posterPath)
        
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

extension Info {
    static func resource(id movie_id : Int) -> Result<Resource<Info>, NetworkError> {
        guard let movieListURL = URL(string : "https://api.themoviedb.org/3/movie/\(movie_id)") else {
            return .failure(.urlError)
        }
        let resource = Resource<Info>(url : movieListURL, parse : { data in
            let decoded = try? JSONDecoder().decode(Info.self, from: data)
            return decoded
        })
        return .success(resource)
    }
}

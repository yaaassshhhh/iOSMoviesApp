//
//  MovieList.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 08/07/25.
//

class MovieListViewModel {
    var movies : [MovieViewModel] = []
    private weak var delegate : MovieListViewControllerDelegate?
}

extension MovieListViewModel {
    func fetchMovies(delegate : MovieListViewControllerDelegate? ) {
        guard let delegate = delegate else {
            return
        }
        self.delegate = delegate
        
    }
}

struct MovieViewModel {
    var movie : Movie
    
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
    var ageRating : Bool {
        return self.movie.ageRating
    }
    var rating : Double {
        return self.movie.rating
    }
}

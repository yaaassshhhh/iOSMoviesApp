//
//  MovieListViewModel.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 08/07/25.
//
import Foundation

class MovieListViewModel {
    var movies : [MovieViewModel] = []
    var filteredMovies : [MovieViewModel] = []
    private weak var delegate : DiscoveryPageViewControllerDelegate?
}

extension MovieListViewModel {
    func fetchMovies(delegate : DiscoveryPageViewControllerDelegate? ) {
        guard let delegate = delegate else {
            return
        }
        self.delegate = delegate
        
        WebService().load(resource: ListResponseJSON.resource()){ result in
            switch result {
            case .success(let movieData) :
                self.storeMovieData(movieData)
                self.delegate?.reloadTableView()
            case .failure(let error) :
                print("Error fetching data : \(error)")
            }
        }
    }
    
    private func storeMovieData (_ movieData : ListResponseJSON) {
//        print(movieData)
        self.movies = movieData.results.map({
            MovieViewModel(movie: $0)
        })
        self.filteredMovies = self.movies
    }
    
    func getMovieViewModel(at index : IndexPath) -> MovieViewModel {
        return self.movies[index.row]
    }
    func numberOfMovies() -> Int {
        return self.movies.count
    }
//    func numberOfItems() -> Int {
//        return self.movies.count
//    }
    func initializeSearch(for searchText: String?){
        self.filteredMovies = []
        guard let searchText  =  searchText else {
            self.filteredMovies = self.movies
            return
        }
        if searchText.isEmpty{
            self.filteredMovies = self.movies
        }else{
            self.filteredMovies = self.movies.filter{$0.movie.title.lowercased().contains(searchText.lowercased())}
        }
    }
}



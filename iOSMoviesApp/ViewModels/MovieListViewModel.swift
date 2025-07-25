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
    
    init(delegate: DiscoveryPageViewControllerDelegate?){
        self.delegate = delegate
    }
}

extension MovieListViewModel {
    
    func fetchMovies() {
        
        guard let delegate: DiscoveryPageViewControllerDelegate = self.delegate else { return }
        
        let result: Result<Resource<ListResponseJSON>, NetworkError> = ListResponseJSON.resource()
        switch result {
        case .success(let resource):
            WebService().load(resource: resource) { result in
                switch result {
                case .success(let movieData) :
                    self.storeMovieData(movieData)
                    delegate.reloadTableData()
                case .failure(let error) :
                    print("Error fetching data : \(error)")
                }
            }
        case .failure(let error):
            print(error)
        }
    }
    
    private func storeMovieData (_ movieData : ListResponseJSON) {
        self.movies = movieData.results.map({
            MovieViewModel(movie: $0)
        })
        self.filteredMovies = self.movies
    }
    
    func getMovieViewModel(at index : IndexPath) -> MovieViewModel {
        return self.filteredMovies[index.row]
    }
    
    func numberOfMovies() -> Int {
        return self.filteredMovies.count
    }

    func initializeSearch(for searchText: String?) {
        
        self.filteredMovies = []
        guard let searchText = searchText else {
            self.filteredMovies = self.movies
            return
        }
        
        let validSearchText = searchText.trimmingCharacters(in: .whitespaces)
        guard !validSearchText.isEmpty else {
            self.filteredMovies = self.movies
            return
        }
        
        let smartSearch = SmartSearchAlgo(searchText : validSearchText)
        self.filteredMovies = self.movies.filter({ movieVM in
            let movieTitle = movieVM.title
            return smartSearch.isMatch(movieTitle)
        })
        
    }
    
}

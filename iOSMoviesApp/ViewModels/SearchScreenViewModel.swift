//
//  RecentSearchViewModel.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 30/07/25.
//
import Foundation

class SearchScreenViewModel {
    
    var movies : [MovieViewModel] = []
    var filteredMovies : [MovieViewModel] = []
    var recentMovies: [MovieViewModel?] = Array(repeating : nil, count : 5)
    
    init(for movies: [MovieViewModel]?){
        self.movies = movies ?? []
        self.filteredMovies = movies ?? []
    }
}

extension SearchScreenViewModel {
    
    func getMovieViewModel(at index : IndexPath) -> MovieViewModel {
        return self.filteredMovies[index.row]
    }
    
    func numberOfMovies() -> Int {
        return self.filteredMovies.count
    }
    
    func updateRecentSearches(with movieVM: MovieViewModel) {
        
        
    }
    func initializeSearch(for searchText: String?) {
        
        updateFilterMovies()
        
        guard let searchText = searchText else {
            updateFilterMovies()
            return
        }
        
        let validSearchText = searchText.trimmingCharacters(in: .whitespaces)
        guard !validSearchText.isEmpty else {
            updateFilterMovies()
            return
        }
        
        let smartSearch = SmartSearchAlgo(searchText : validSearchText)
        self.filteredMovies = self.movies.filter({ movieVM in
            let movieTitle = movieVM.title
            return smartSearch.isMatch(movieTitle)
        })
    }
    
   private func updateFilterMovies() {
       self.filteredMovies.removeAll()
        for movieVM in self.recentMovies {
            guard let movieVM = movieVM else {
                break
            }
            self.filteredMovies.append(movieVM)
        }
    }
}

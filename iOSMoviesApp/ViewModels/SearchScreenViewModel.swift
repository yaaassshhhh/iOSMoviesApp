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
    
    init(for movieListVM: MovieListViewModel?){
        self.movies = movieListVM?.movies ?? []
    }
}

extension SearchScreenViewModel {
    
    func getMovieViewModel(at index : Int) -> MovieViewModel? {
        
        print("filteredMovies count - \(filteredMovies.count)")
        print("filteredMovies index - \(index)")
        if filteredMovies.isEmpty || index >= filteredMovies.count {
            print("\n filteredMovies inside getMovieViewModel - \n \(filteredMovies)")
            return nil
        }
        print("\n filteredMovies inside getMovieViewModel - \n \(filteredMovies)")
        return self.filteredMovies[index]
    }
    
    func numberOfMovies() -> Int {
        return self.filteredMovies.count
    }
    
    func updateRecentSearches(with movieVM: MovieViewModel) {
        if(recentMovies.endIndex < 4){
            self.recentMovies.insert(movieVM, at: 0)
        } else {
            self.recentMovies.removeLast()
            self.recentMovies.insert(movieVM, at: 0)
        }
    }
    
    func initializeSearch(for searchText: String?) {
        print("Inside initializeSearch")
        filteredMovies.removeAll()
        
        guard let searchText = searchText else {
            return
        }
        print("\n search text -- \(searchText)")
        
        let validSearchText = searchText.trimmingCharacters(in: .whitespaces)
        print("\(validSearchText)")
        guard !validSearchText.isEmpty else {
            return
        }
        
        let smartSearch = SmartSearchAlgo(searchText : validSearchText)
        self.filteredMovies = self.movies.filter({ movieVM in
            let movieTitle = movieVM.title
            return smartSearch.isMatch(movieTitle)
        })
        print("filteredMovies inside search - \n \(filteredMovies)")
    }
    
}

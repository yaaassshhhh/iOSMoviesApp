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
//        print(index.row)
        print("filteredMovies count - \(filteredMovies.count)")
        print("filteredMovies index - \(index)")
        if filteredMovies.isEmpty || index > filteredMovies.count {
            print("\n filteredMovies inside getMovieViewModel - \n \(filteredMovies)")
            return nil
        }
        print("\n filteredMovies inside getMovieViewModel - \n \(filteredMovies)")
        return self.filteredMovies[index-1]
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
        updateFilterMovies()
    }
    
    func initializeSearch(for searchText: String?) {
        print("Inside initializeSearch")
//        updateFilterMovies()

        guard let searchText = searchText else {
            updateFilterMovies()
            return
        }
        print("\n search text -- \(searchText)")
        
        let validSearchText = searchText.trimmingCharacters(in: .whitespaces)
        print("\(validSearchText)")
        guard !validSearchText.isEmpty else {
            updateFilterMovies()
            return
        }
        
        let smartSearch = SmartSearchAlgo(searchText : validSearchText)
        self.filteredMovies = self.movies.filter({ movieVM in
            let movieTitle = movieVM.title
            return smartSearch.isMatch(movieTitle)
        })
        print("filteredMovies inside search - \n \(filteredMovies)")
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

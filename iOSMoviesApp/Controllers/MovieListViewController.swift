////
////  MovieListViewController.swift
////  iOSMoviesApp
////
////  Created by Yash Agrawal on 08/07/25.
////
//
//import Foundation
//import UIKit
//protocol MovieListViewControllerDelegate: AnyObject {
//    func reloadTableView()
//}
//class MovieListTableViewController: UITableView {
//
//    private var movieListVM = MovieListViewModel()
//    
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        setupTableView()
////        movieListVM.fetchMovies(delegate: self)
////    }
////    func setupTableView() {
////        self.tableView.register(UINib(nibName: "MovieCardTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCardTableViewCell")
////        
////    }
//}
//
//// MARK: - UITableViewDelegate & UITableViewDataSource
//extension MovieListTableViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return movieListVM.numberOfMovies()
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cellVM = self.movieListVM.getMovieViewModel(at: indexPath)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCardTableViewCell", for : indexPath) as? MovieCardTableViewCell
//        guard let cell = cell else { return UITableViewCell() }
//        cell.configureState(for : cellVM)
//        return cell
//    }
//}
//extension MovieListTableViewController: MovieListViewControllerDelegate {
//    func reloadTableView() {
//        self.tableView.reloadData()
//    }
//}

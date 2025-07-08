//
//  MovieListViewController.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 08/07/25.
//

import Foundation
import UIKit
protocol MovieListViewControllerDelegate: AnyObject {
    func reloadTableView()
}
class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var movieListVM: MovieListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListVM.numberOfMovies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVM = self.movieListVM.getMovieViewModel(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCardTableViewCell", for : indexPath) as? MovieCardTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        cell.configureState(for : cellVM)
        return cell
    }
}
extension MovieListViewController: MovieListViewControllerDelegate {
    func reloadTableView() {
        self.tableView.reloadData()
    }
}

//
//  DiscoveryPageViewController.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 08/07/25.
//

import Foundation
import UIKit
protocol DiscoveryPageViewControllerDelegate: AnyObject{
    func reloadTableView()
    func reloadCarouselView()
}

class DiscoveryPageViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    private var movieListVM = MovieListViewModel()
    
    @IBOutlet weak var carouselCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        movieListVM.fetchMovies(delegate: self)
        setupTableView()
        setupSearchBar()
        setupCarousel()
    }
    func setupTableView() {
        self.tableView.register(UINib(nibName: "MovieCardTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCardTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupSearchBar() {
        searchBar.delegate = self
    }

    private func setupCarousel() {
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self

        let nib = UINib(nibName: "MovieCarouselCell", bundle: nil)
        carouselCollectionView.register(nib, forCellWithReuseIdentifier: "MovieCarouselCell")

        if let layout = carouselCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 200, height: 300)
            layout.minimumLineSpacing = 16
        }

        carouselCollectionView.showsHorizontalScrollIndicator = false
    }

//    private func fetchData() {
//        viewModel.fetchMovies { [weak self] in
//            DispatchQueue.main.async {
//                self?.carouselCollectionView.reloadData()
//            }
//        }
//    }

}

extension DiscoveryPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieListVM.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCarouselCell", for: indexPath) as? MovieCarouselCell else {
            return UICollectionViewCell()
        }

//        let movie = viewModel.featuredMovies[indexPath.row]
        let movieVM = movieListVM.getMovieViewModel(at: indexPath)
        cell.configure(with: movieVM)
        return cell
    }
}

extension DiscoveryPageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        viewModel.filterMovies(query: searchText)
//        carouselCollectionView.reloadData()
        movieListVM.initializeSearch(for: searchText)
        self.reloadCarouselView()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
//        viewModel.filterMovies(query: "")
        movieListVM.initializeSearch(for: nil)
        self.reloadTableView()
        self.reloadCarouselView()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

extension DiscoveryPageViewController: UITableViewDelegate, UITableViewDataSource {

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

extension DiscoveryPageViewController : DiscoveryPageViewControllerDelegate {
   func reloadTableView() {
       DispatchQueue.main.async{
           self.tableView.reloadData()
       }
   }
    func reloadCarouselView() {
        DispatchQueue.main.async{
            self.carouselCollectionView.reloadData()
        }
    }
}

//
//  DiscoveryPageViewController.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 08/07/25.
//

import Foundation
import UIKit

class DiscoveryPageViewController: UIViewController {

    @IBOutlet weak var carouselCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    let viewModel = DiscoveryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
        setupCarousel()
        fetchData()
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

    private func fetchData() {
        viewModel.fetchMovies { [weak self] in
            DispatchQueue.main.async {
                self?.carouselCollectionView.reloadData()
            }
        }
    }

}

extension DiscoveryPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.featuredMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCarouselCell", for: indexPath) as? MovieCarouselCell else {
            return UICollectionViewCell()
        }

        let movie = viewModel.featuredMovies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
}

extension DiscoveryPageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterMovies(query: searchText)
        carouselCollectionView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.filterMovies(query: "")
        carouselCollectionView.reloadData()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}


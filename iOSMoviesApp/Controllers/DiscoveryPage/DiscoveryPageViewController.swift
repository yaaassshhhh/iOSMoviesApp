//
//  DiscoveryPageViewController.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 08/07/25.
//

import Foundation
import UIKit
import CoreLocation

protocol DiscoveryPageViewControllerDelegate: AnyObject{
    func reloadTableView()
}

class DiscoveryPageViewController: UIViewController{
    
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var movieListVM : MovieListViewModel!
    let locationService : LocationService = LocationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationService()
        setupUI()
    }
    
    private func setupUI() {
        movieListVM = MovieListViewModel(delegate : self)
        movieListVM.fetchMovies()
        setupTableView()
        setupSearchBar()
    }
    
    func setupTableView() {
        self.tableView.register(UINib(nibName: "MovieCardTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCardTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
    }
}

extension DiscoveryPageViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieListVM.initializeSearch(for: searchText)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        movieListVM.initializeSearch(for: nil)
        self.reloadTableView()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

extension DiscoveryPageViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListVM.numberOfMovies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellVM: MovieViewModel = self.movieListVM.getMovieViewModel(at: indexPath)
        
        guard let cell: MovieCardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MovieCardTableViewCell", for : indexPath) as? MovieCardTableViewCell else {
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
            return UITableViewCell()
        }
        
        cell.configureState(with : cellVM)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsVC: DetailsScreenViewController? = UIStoryboard.init(name : "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "detailsViewC") as? DetailsScreenViewController
        let selectedMovieVM: MovieViewModel = movieListVM.getMovieViewModel(at: indexPath)
        
        guard let detailsVC: DetailsScreenViewController = detailsVC else {
            return
        }
        detailsVC.setupMovie(movieVM: selectedMovieVM)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension DiscoveryPageViewController : DiscoveryPageViewControllerDelegate {
   func reloadTableView() {
       DispatchQueue.main.async{
           self.tableView.reloadData()
       }
   }
}

extension DiscoveryPageViewController : LocationServiceDelegate {
    
    func didUpdateLocation(_ placeName : String) {
        locationBtn.setTitle(placeName, for: .normal)
        locationService.stopUpdatingLocation()
    }
    
    private func setupLocationService() {
        locationService.delegate = self
        locationService.requestLocationAccess()
    }
    
    func didUpdateAuthorizationStatus(_ status: CLAuthorizationStatus) {
        switch status {
                case .authorizedWhenInUse, .authorizedAlways:
                    locationService.startUpdatingLocation()
                case .denied, .restricted:
                    print("Location permission denied.")
                case .notDetermined:
                    break
                @unknown default:
                    break
        }
    }
}

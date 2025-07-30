//
//  SearchScreenViewController.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 30/07/25.
//

import UIKit

protocol SearchScreenViewControllerDelegate: DiscoveryPageViewControllerDelegate {
    func updateRecentSearches(with movies: MovieViewModel)
}
class SearchScreenViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var searchVM : SearchScreenViewModel?
    weak var delegate: DiscoveryPageViewControllerDelegate?
    

    private var searchText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()

    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    private func setupTableView() {
        self.tableView.register(UINib(nibName: "MovieCardTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCardTableViewCell")
        let searchTitleNib: UINib = UINib(nibName: "SearchTitleTableViewCell", bundle: nil)
        tableView.register(searchTitleNib, forCellReuseIdentifier: "SearchTitleTableViewCell")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    func configure(for viewModel: MovieListViewModel,_ delegate: DiscoveryPageViewControllerDelegate) {
        self.delegate = delegate
        searchVM = SearchScreenViewModel(for: viewModel)

    }
    
    func reloadTableData() {
        self.tableView.reloadData()
    }
}

extension SearchScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (searchVM?.numberOfMovies() ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let position : Int = indexPath.row
        
        guard let searchVM = searchVM else {
            print("\n default cell in guard let")
            return UITableViewCell()
        }
        
        switch position {
        case 0:
           guard let cell = dequeueTitleCell(indexPath: indexPath) else {
            return dequeueDefaultCell(indexPath: indexPath)
        }
        cell.configure(searchText)
        return cell
        default:
            
            guard let cellVM: MovieViewModel = searchVM.getMovieViewModel(at: position) else {
                print("\n default cell in guard let cellVM: MovieViewModel")
                return UITableViewCell()
            }
            
            guard let cell: MovieCardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MovieCardTableViewCell", for : indexPath) as? MovieCardTableViewCell else {
                print("\n default cell in guard let cell: MovieCardTableViewCell")
                return UITableViewCell()
            }
            
            cell.configureState(with : cellVM, delegate : self.delegate, indexPath : indexPath)
            return cell
        }
        
    }

}

extension SearchScreenViewController {
    private func dequeueTitleCell(indexPath : IndexPath) -> SearchTitleTableViewCell? {
        
        guard let cell: SearchTitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchTitleTableViewCell", for: indexPath) as? SearchTitleTableViewCell else {
            return nil
        }
        return cell
    }
    
    private func dequeueDefaultCell(indexPath : IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

extension SearchScreenViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        self.searchText = searchText
        guard let searchVM = searchVM else { return }
        print("Initialize search")

        searchVM.initializeSearch(for: searchText)
        print("Initialize search reloading table")
        self.reloadTableData()

    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.searchText = "" 
        searchBar.resignFirstResponder()

        guard let searchVM = searchVM else { return }
        searchVM.initializeSearch(for: searchBar.text)

        self.reloadTableData()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

//extension SearchScreenViewController : SearchScreenViewControllerDelegate {
//    func updateRecentSearches(with cellVM: MovieViewModel) {
//        guard let searchVM = searchVM else { return }
//        searchVM.updateRecentSearches(with: cellVM)
//    }
//}

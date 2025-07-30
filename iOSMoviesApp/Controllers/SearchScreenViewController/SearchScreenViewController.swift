//
//  SearchScreenViewController.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 30/07/25.
//

import UIKit

class SearchScreenViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var searchText: String = ""
    private var searchVM : SearchScreenViewModel!
    private var movies: [MovieViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        setupViewModel()
    }
    
    func setupMovies(_ movies: [MovieViewModel]) {
        self.movies = movies
        setupViewModel() 
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func setupViewModel() {
        searchVM = SearchScreenViewModel(for: movies)
    }
    
    func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        let searchTitleNib: UINib = UINib(nibName: "SearchTitleTableViewCell", bundle: nil)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(searchTitleNib, forCellReuseIdentifier: "SearchTitleTableViewCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none
    }
    
    func reloadTableData() {
        self.tableView.reloadData()
    }
}

extension SearchScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            case 0:
                guard let cell = dequeueTitleCell(indexPath: indexPath) else {
                    return dequeueDefaultCell(indexPath: indexPath)
                }
                cell.configure(searchText)
                return cell
            default:
                return dequeueDefaultCell(indexPath: indexPath)
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
        searchVM.initializeSearch(for: searchText)
        self.reloadTableData()

    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.searchText = "" 
        searchBar.resignFirstResponder()
        searchVM.initializeSearch(for: "") 
        self.reloadTableData()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}



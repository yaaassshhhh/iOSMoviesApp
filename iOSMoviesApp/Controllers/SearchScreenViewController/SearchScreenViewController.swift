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
    
    private var searchText: String?
    private var searchVM : SearchScreenViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
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
        
        let position : Int = indexPath.row
        
        switch position {
            case 0:
                let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
            return cell
        default:
            fatalError("Invalid position")
        }
    }
    
}

    
extension SearchScreenViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard let searchVC: SearchScreenViewController = UIStoryboard.init(name : "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "searchVC") as? SearchScreenViewController else {
            return
        }
        
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchVM.initializeSearch(for: searchText)
            self.reloadTableData()
        }
    
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(true, animated: true)
        }
    
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
            searchBar.resignFirstResponder()
            movieListVM.initializeSearch(for: searchBar.text)
            self.reloadTableData()
            searchBar.setShowsCancelButton(false, animated: true)
        }
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.text = ""
//        searchBar.resignFirstResponder()
//        //        movieListVM.initializeSearch(for: searchBar.text)
//        //        self.reloadTableData()
//        searchBar.setShowsCancelButton(false, animated: true)
//    }
}



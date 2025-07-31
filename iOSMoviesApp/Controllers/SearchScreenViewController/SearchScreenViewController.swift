//
//  SearchScreenViewController.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 30/07/25.
//

import UIKit

protocol SearchScreenViewControllerDelegate: AnyObject  {
    func updateRecentSearches(with movies: MovieViewModel)
}
class SearchScreenViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var searchTitleLabel: UILabel!

    private var searchVM : SearchScreenViewModel?
    weak var delegate: DiscoveryPageViewControllerDelegate?
    

    private var searchText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupTitle()
        setupSearchBar()
        setupTableView()
    }
    private func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func setupTitle() {
        if searchText.isEmpty {
            searchTitleLabel.text = "Recent Searched"
        } else {
            searchTitleLabel.text = "Searched Results"
        }
    }
    
    private func setupTableView() {
        self.tableView.register(UINib(nibName: "MovieCardTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCardTableViewCell")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieVM = searchVM?.getMovieViewModel(at: indexPath.row) else { return }
        searchVM?.updateRecentSearches(with: movieVM)
        delegate?.navigateToDetails(for: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let position : Int = indexPath.row
        
        guard let searchVM = searchVM else {
            print("\n default cell in guard let")
            return UITableViewCell()
        }
            
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

extension SearchScreenViewController : SearchScreenViewControllerDelegate {
    
    func updateRecentSearches(with movies: MovieViewModel) {
        
        let cacheKey: NSString = NSString(string: String(movies.id))
        
        guard let movieVM = RecentSearchedCache.shared.object(forKey: cacheKey) as? MovieViewModel else {
            setUpCache(movies, cacheKey)
        }
        if movieVM {
            
        }
            
        }
        setUpCache(movies, cacheKey)

    }
    func setUpCache(_ movieVM : MovieViewModel, _ cacheKey : NSString){
        RecentSearchedCache.shared.setObject(movieVM, forKey: cacheKey)
    }
}

//
//  SearchScreenViewController.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 30/07/25.
//

import UIKit

protocol RecentSearchNavigationDelegate: AnyObject {
    func didSelectRecentMovie(with movieId: Int)
}
class SearchScreenViewController: UIViewController {
//    
//    init(){
//        
//    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var searchTitleLabel: UILabel!

    private var searchVM : SearchScreenViewModel?
    weak var delegate: DiscoveryPageViewControllerDelegate?
    private var recentMovieList : [MovieViewModel]?
    weak var recentDelegate: RecentSearchNavigationDelegate?
    
    

    private var searchText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupTitle()
        setupSearchBar()
        setupTableView()
        setupRecentSearchData()
    }
    
    func setupRecentSearchData() {
        recentMovieList = RecentSearchedCache.searched.getRecentMovies()
        print("Recent movie list : \(recentMovieList ?? [])")
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
        self.tableView.register(UINib(nibName: "RecentSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentSearchTableViewCell")
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
        
        let didSearch: Bool = !searchText.isEmpty
    
        switch didSearch {
        case true:
            guard let movieVM = searchVM?.getMovieViewModel(at: indexPath.row) else { return }
            RecentSearchedCache.searched.addRecentMovie(movie: movieVM)
            delegate?.navigateToDetails(for: indexPath.row)
            
        case false :
            guard let recentMovieVM = recentMovieList?[indexPath.row] else { return }
            RecentSearchedCache.searched.addRecentMovie(movie: recentMovieVM)
            recentDelegate?.didSelectRecentMovie(with: recentMovieVM.id)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let position : Int = indexPath.row
        
        guard let searchVM = searchVM else {
            print("\n default cell in guard let")
            return UITableViewCell()
        }
        
        let didSearch: Bool = !searchText.isEmpty
        
        switch didSearch {
        case true:
            
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
            
        case false:
            if recentMovieList?.count == 0 || recentMovieList?.count == nil {
                return UITableViewCell()
            }
            let recentMovieVM = recentMovieList?[indexPath.row]
            
            let cell: RecentSearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchTableViewCell", for : indexPath) as! RecentSearchTableViewCell
            guard let recentMovieVM = recentMovieVM else {
                return cell
            }
            cell.configure(with: recentMovieVM)
            return cell
        }
    }

}

extension SearchScreenViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        self.searchText = searchText
        guard let searchVM = searchVM else { return }
        print("Initialize search")
        setupTitle()

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

extension SearchScreenViewController : RecentSearchNavigationDelegate{
    func didSelectRecentMovie(with movieId: Int) {
        navigateToMovieDetails(with: movieId)
    }
    
    private func navigateToMovieDetails(with movieId: Int) {
        guard let detailsVC: DetailsScreenViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "detailsViewC") as? DetailsScreenViewController else {
            return
        }
        
        let movieVM = createMovieViewModel(with: movieId)
        print("Hello i am tapped")
        detailsVC.setupMovie(movieVM: movieVM)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    private func createMovieViewModel(with movieId: Int) -> MovieViewModel {
        let movie = Movie(
            title: nil,
            releaseDate: nil,
            posterPath: nil,
            description: nil,
            id: movieId
        )
        
        return MovieViewModel(movie: movie)
    }
}

//
//  DetailsScreenViewController.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 11/07/25.
//

import Foundation
import UIKit

protocol ViewControllerTableReloadDelegate: AnyObject {
    func reloadTableData()
}

final class DetailsScreenViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var detailsVM : DetailsScreenViewModel!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getDetails()
    }
    
    private func setupUI() {
        setupTableView()
    }
    
    func setupMovie(movieVM : MovieViewModel){
        self.detailsVM = DetailsScreenViewModel(delegate: self)
        self.detailsVM.movie = movieVM
    }
    
    private func getDetails() {
        detailsVM.fetchCastDetails()
        detailsVM.fetchSimilarDetails()
        detailsVM.fetchMovieInfo()
        detailsVM.fetchReviewDetails()
    }
    
    @IBAction func backToDiscovery(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailsScreenViewController: UITableViewDataSource , UITableViewDelegate {
    
    private func setupTableView() {
        let castNib: UINib = UINib(nibName: "CastDetailsTableViewCell", bundle: nil)
        let similarNib: UINib = UINib(nibName: "SimilarTableViewCell", bundle: nil)
        let reviewNib: UINib = UINib(nibName: "ReviewTableViewCell", bundle: nil)
        let infoNib: UINib = UINib(nibName: "InfoTableViewCell", bundle: nil)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(castNib, forCellReuseIdentifier: "CastDetailsTableViewCell")
        tableView.register(similarNib, forCellReuseIdentifier: "SimilarTableViewCell")
        tableView.register(reviewNib, forCellReuseIdentifier: "ReviewTableViewCell")
        tableView.register(infoNib, forCellReuseIdentifier: "InfoTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        // Ensure proper sizing for cells
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
        // Remove separators that might interfere
        tableView.separatorStyle = .none
        
        print("📏 Table view frame: \(tableView.frame)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailsVM.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height : CGFloat = detailsVM.setCellHeight(indexPath.row)
        if height == 0 {
            return UITableView.automaticDimension
        } else {
            return height
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let position : Int = indexPath.row
        
        switch position {
        case 0 :
            guard let cell: InfoTableViewCell = dequeueInfoCell(indexPath: indexPath) else {
                break
            }
            
            cell.configureState(with: detailsVM.getMovieInfo() ?? nil)
            return cell
            
        case 1 :
            guard let cell: ReviewTableViewCell = dequeueReviewCell(indexPath: indexPath) else {
                break
            }
            cell.configure(detailsVM.getAllReviewModel())
            return cell
            
        case 2 :
            guard let cell : CastDetailsTableViewCell = dequeueCastCell(indexPath: indexPath) else {
                break
            }
            cell.configureState(detailsVM.getAllCastViewModel())
            return cell
            
        case 3 :
            guard let cell : SimilarTableViewCell = dequeueSimilarCell(indexPath: indexPath) else {
                break
            }
            cell.delegate = self
            cell.configureState(detailsVM.getAllSimilarViewModel())
            return cell
            
        default :
            return dequeueDefaultCell(indexPath: indexPath)
        }

        return dequeueDefaultCell(indexPath: indexPath)
    }
    
    private func dequeueInfoCell(indexPath : IndexPath) -> InfoTableViewCell? {
        
        guard let cell: InfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as? InfoTableViewCell else {
            return nil
        }
        return cell
    }
    
    private func dequeueCastCell(indexPath : IndexPath) -> CastDetailsTableViewCell? {
        
        guard let cell: CastDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CastDetailsTableViewCell", for: indexPath) as? CastDetailsTableViewCell else {
            return nil
        }
        return cell
    }
    
    private func dequeueSimilarCell(indexPath : IndexPath) -> SimilarTableViewCell? {
        
        guard let cell: SimilarTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SimilarTableViewCell", for: indexPath) as? SimilarTableViewCell else {
            return nil
        }
        return cell
    }
    
    private func dequeueReviewCell(indexPath : IndexPath) -> ReviewTableViewCell? {
        
        guard let cell: ReviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as? ReviewTableViewCell else {
            return nil
        }
        return cell
    }
    
    private func dequeueDefaultCell(indexPath : IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension DetailsScreenViewController: ViewControllerTableReloadDelegate {

    func reloadTableData() {
        self.tableView.reloadData()
    }
}

extension DetailsScreenViewController: SimilarMovieSelectionDelegate {
    
    func didSelectSimilarMovie(with movieId: Int) {
        navigateToMovieDetails(with: movieId)
    }
    
    private func navigateToMovieDetails(with movieId: Int) {
        guard let detailsVC: DetailsScreenViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "detailsViewC") as? DetailsScreenViewController else {
            return
        }
        
        let movieVM = createMovieViewModel(with: movieId)
        
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

//extension DetailsScreenViewController: SearchScreenViewControllerDelegate {
//    func updateRecentSearches(with movies: MovieViewModel) {
//        <#code#>
//    }
//    
//    private func navigateToDetails(with movieId: Int) {
//        guard let detailsVC: DetailsScreenViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "detailsViewC") as? DetailsScreenViewController else {
//            return
//        }
//        
//        let movieVM = createMovieViewModel(with: movieId)
//        
//        detailsVC.setupMovie(movieVM: movieVM)
//        self.navigationController?.pushViewController(detailsVC, animated: true)
//    }
//}

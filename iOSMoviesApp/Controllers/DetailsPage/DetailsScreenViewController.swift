//
//  DetailsScreenViewController.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 11/07/25.
//

import Foundation
import UIKit

protocol DetailsScreenViewControllerDelegate : AnyObject {
    func numberOfCasts() -> Int
    func getCastVM(at index : Int) -> CastViewModel
    func reloadTableData()
}
class DetailsScreenViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var detailsVM = DetailsScreenViewModel()
//    {
//        didSet {
//            getDetails()
//        }
//    }
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
        self.detailsVM.movie = movieVM
    }
    private func getDetails() {
        print("Calling Cast APi ...")
        detailsVM.fetchCastDetails(delegate: self)
    }
}

extension DetailsScreenViewController: UITableViewDataSource , UITableViewDelegate {
    
    private func setupTableView() {
//        tableView.register(CastDetailsTableViewCell.self, forCellReuseIdentifier: "CastDetailsTableViewCell")
        let castNib = UINib(nibName: "CastDetailsTableViewCell", bundle: nil)
        let reviewNib = UINib(nibName: "ReviewTableViewCell", bundle: nil)
        tableView.register(castNib, forCellReuseIdentifier: "CastDetailsTableViewCell")
        tableView.register(reviewNib, forCellReuseIdentifier: "ReviewTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailsVM.numberOfRows()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1:
            return 265
        default:
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let position = indexPath.row
        switch position {
        case 0 :
            return UITableViewCell()
        case 1 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastDetailsTableViewCell", for: indexPath) as? CastDetailsTableViewCell else {
                break
            }
            cell.configureState(detailsVM.getAllCastViewModel(), delegate : self)
            return cell
        case 2 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as? ReviewTableViewCell else {
                break
            }
            return cell
        case 3 :
            return UITableViewCell()
        default :
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
}

extension DetailsScreenViewController: DetailsScreenViewControllerDelegate {
    func numberOfCasts() -> Int {
        return detailsVM.getNumberOfCasts()
    }
    func getCastVM(at index: Int) -> CastViewModel {
        return detailsVM.getCastViewModel(at: index)
    }
    func reloadTableData() {
        self.tableView.reloadData()
    }
}

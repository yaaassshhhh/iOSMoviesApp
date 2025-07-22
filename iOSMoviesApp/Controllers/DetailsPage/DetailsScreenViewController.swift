//
//  DetailsScreenViewController.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 11/07/25.
//

import Foundation
import UIKit

protocol DetailsScreenViewControllerDelegate: AnyObject {
    func reloadTableData()
}

class DetailsScreenViewController: UIViewController {

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
        detailsVM.fetchMovieInfo()
    }
    
    @IBAction func backToDiscovery(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailsScreenViewController: UITableViewDataSource , UITableViewDelegate {
    
    private func setupTableView() {
        let castNib = UINib(nibName: "CastDetailsTableViewCell", bundle: nil)
        let reviewNib = UINib(nibName: "ReviewTableViewCell", bundle: nil)
        let infoNib = UINib(nibName: "InfoTableViewCell", bundle: nil)
        
        tableView.register(castNib, forCellReuseIdentifier: "CastDetailsTableViewCell")
        tableView.register(reviewNib, forCellReuseIdentifier: "ReviewTableViewCell")
        tableView.register(infoNib, forCellReuseIdentifier: "InfoTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailsVM.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            case 0 :
                return PresetSizeValue.infoCellHeight
            case 2 :
                return PresetSizeValue.castCellHeight
            default :
                return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let position : Int = indexPath.row
        
        switch position {
            
        case 0 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as? InfoTableViewCell else {
                break
            }
            cell.configureState(with: detailsVM.getMovieInfo() ?? nil)
            return cell
            
        case 1 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as? ReviewTableViewCell else {
                break
            }
            return cell
            
        case 2 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastDetailsTableViewCell", for: indexPath) as? CastDetailsTableViewCell else {
                break
            }
            cell.configureState(detailsVM.getAllCastViewModel())
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

    func reloadTableData() {
        self.tableView.reloadData()
    }
}

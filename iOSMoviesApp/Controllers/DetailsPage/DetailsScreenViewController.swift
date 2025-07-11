//
//  DetailsScreenViewController.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 11/07/25.
//

import Foundation
import UIKit

protocol DetailsScreenViewControllerDelegate : AnyObject {
    
}
class DetailsScreenViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var detailsVM = DetailsScreenViewModel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupTableView()
    }


    
}

extension DetailsScreenViewController: UITableViewDataSource , UITableViewDelegate {
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailsVM.numberOfRows()
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
            return cell
        case 2 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewSectionCell", for: indexPath) as? ReviewSectionCell else {
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

//
//  MovieListViewController.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 08/07/25.
//

import Foundation
import UIKit

protocol MovieListViewControllerDelegate {
    func reloadTableView()
}
class MovieListViewController : UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MovieListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
extension MovieListViewController: MovieListViewControllerDelegate {
    func reloadTableView() {
        self.tableView.reloadData()
    }
}

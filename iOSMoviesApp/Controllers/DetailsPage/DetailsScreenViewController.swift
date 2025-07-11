//
//  DetailsScreenViewController.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 11/07/25.
//

import Foundation
import UIKit

class DetailsScreenViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var reviews: [Review] = [
        Review(name: "Alice", comment: "Amazing movie!"),
        Review(name: "Bob", comment: "Pretty good."),
        Review(name: "Charlie", comment: "Not bad.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        //ReviewCell
        tableView.register(UINib(nibName: "ReviewSectionCell", bundle: nil), forCellReuseIdentifier: "ReviewSectionCell")

        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}

extension DetailsScreenViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewSectionCell", for: indexPath) as! ReviewSectionCell
        cell.configure(with: reviews)
        return cell
    }
}

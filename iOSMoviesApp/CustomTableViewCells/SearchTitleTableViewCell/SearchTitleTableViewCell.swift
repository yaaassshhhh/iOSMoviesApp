//
//  SearchTitleTableViewCell.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 30/07/25.
//

import UIKit



class SearchTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ searchText: String) {
        if searchText.isEmpty {
            searchTitleLabel.text = "Recent Searched"
        } else {
            searchTitleLabel.text = "Searched Results"
        }
    }
    
}


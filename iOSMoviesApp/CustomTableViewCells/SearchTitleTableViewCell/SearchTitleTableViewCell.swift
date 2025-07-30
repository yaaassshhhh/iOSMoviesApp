//
//  SearchTitleTableViewCell.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 30/07/25.
//

import UIKit



class SearchTitleTableViewCell: UITableViewCell, SearchTitleChangeDelegate {
    
    @IBOutlet weak var searchTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func searchTextDidChange(_ searchText: String) {
        if(searchText.isEmpty){
            print("I am empty")
            searchTitleLabel.text = "Recent Searched"
        }
        else{
            print("I am full")
            searchTitleLabel.text = "Searched Results"
        }
    }
    
}


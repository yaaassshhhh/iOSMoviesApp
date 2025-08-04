//
//  RecentSearchTableViewCell.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 31/07/25.
//

import UIKit

class RecentSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recentTitle: UILabel!
    
    private var recentVM: MovieViewModel!
    
    func configure(with viewModel: MovieViewModel) {
        self.recentTitle.text = viewModel.title
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }

    
}

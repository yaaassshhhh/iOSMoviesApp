//
//  ReviewCollectionViewCell.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 28/07/25.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    private var reviewVM: ReviewViewModel?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = true
    }

    func configure(_ reviewData: ReviewViewModel?) {
        
        guard let reviewData = reviewData else { return }
        self.reviewVM = reviewData
        
        setupReviewAuthor()
        setupReviewComment()
    }
    
    private func setupReviewAuthor() {
        guard let author = reviewVM?.name else { return }
        nameLabel.text = author
        nameLabel.setLinesByWord()
    }
    
    private func setupReviewComment() {
        guard let comment = reviewVM?.comment else { return }
        commentLabel.text = comment
        commentLabel.setLinesByWord()
    }
    
}


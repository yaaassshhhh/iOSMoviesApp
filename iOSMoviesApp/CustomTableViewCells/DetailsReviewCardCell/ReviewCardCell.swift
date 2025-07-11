//
//  ReviewCardCell.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 11/07/25.
//

import UIKit

class ReviewCardCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = true
    }

    func configure(with review: Review) {
        nameLabel.text = review.name
        commentLabel.text = review.comment
    }
}

//
//  ReviewCollectionViewCell.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 28/07/25.
//

import UIKit

private enum Style {
    static let cornerRadius: CGFloat = 12
    static let borderWidth: CGFloat = 0.5
    static let borderColor: CGColor = UIColor.lightGray.cgColor
}
    
class ReviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.setLinesByWord()
        }
    }
    @IBOutlet weak var commentLabel: UILabel!{
        didSet {
            commentLabel.setLinesByWord()
        }
    }
    private var reviewVM: ReviewViewModel?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        self.layer.cornerRadius = Style.cornerRadius
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.systemGray6
        self.layer.borderWidth = Style.borderWidth
        self.layer.borderColor = Style.borderColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel?.text = ""
        commentLabel?.text = ""
    }

    func configure(_ reviewData: ReviewViewModel?) -> Void {
        guard let reviewData = reviewData else {
            nameLabel?.text = "No Author"
            commentLabel?.text = "No Review Available"
            return 
        }
        
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


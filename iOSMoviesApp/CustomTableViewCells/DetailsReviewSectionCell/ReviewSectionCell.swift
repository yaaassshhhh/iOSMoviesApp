//
//  ReviewSectionCell.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 11/07/25.
//

import UIKit

class ReviewSectionCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    var reviews: [Review] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "ReviewCardCell", bundle: nil), forCellWithReuseIdentifier: "ReviewCardCell")
    }
    
    func configure(with reviews: [Review]) {
        self.reviews = reviews
        titleLabel.text = "Reviews"
        collectionView.reloadData()
    }

}

extension ReviewSectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCardCell", for: indexPath) as! ReviewCardCell
        cell.configure(with: reviews[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 130)
    }
}

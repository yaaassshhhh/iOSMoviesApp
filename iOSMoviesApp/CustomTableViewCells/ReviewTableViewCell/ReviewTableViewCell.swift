//
//  ReviewSectionCell.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 11/07/25.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewsCollectionView: UICollectionView!

   private var reviewDetailsVM: ReviewDetailsViewModel?

   override func awakeFromNib() {
       super.awakeFromNib()
       self.selectionStyle = .none
//       reviewsCollectionView.backgroundColor = .red
       print("Loaded ReviewTableViewCell — reviewCollectionView: \(String(describing: reviewsCollectionView))")
   }

    func configure(_ reviewDetailsVM : ReviewDetailsViewModel) {
        self.reviewDetailsVM = reviewDetailsVM
        print("🛠️ Configuring review cell with count: \(reviewDetailsVM.numberOfReviews())")
        setupCollectionView()
        self.reloadReviewView()
   }
}

extension ReviewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func setupCollectionView() {
        let nib: UINib = UINib(nibName: "ReviewCollectionViewCell", bundle: nil)
        reviewsCollectionView.register(nib, forCellWithReuseIdentifier: "ReviewCollectionViewCell")
        reviewsCollectionView.delegate = self
        reviewsCollectionView.dataSource = self
    }
    

   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       let count = reviewDetailsVM?.numberOfReviews() ?? 0
       print("📌 Review count: \(count)")
       return count
   }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
       guard let cell: ReviewCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionViewCell", for: indexPath) as? ReviewCollectionViewCell else {
           self.reviewsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
           return UICollectionViewCell()
       }
       cell.configure(reviewDetailsVM?.getReviewViewModel(at: indexPath.row))
       return cell
   }
    
    private func reloadReviewView() {
        self.reviewsCollectionView.reloadData()
    }
}

extension ReviewTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return PresetSizeValue.reviewCollectionViewItemSize
    }
}

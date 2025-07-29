

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    private var reviewDetailsVM: ReviewDetailsViewModel?
    
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    @IBOutlet weak var reviewsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setupUI()
    }
    
    func setupUI() {
        reviewsLabel?.translatesAutoresizingMaskIntoConstraints = true
        reviewsLabel?.frame = CGRect(x: 15, y: 20, width: 200, height: 25)
        
        reviewCollectionView?.translatesAutoresizingMaskIntoConstraints = true
        
        reviewCollectionView?.backgroundColor = UIColor.clear
        reviewCollectionView?.showsHorizontalScrollIndicator = false
        reviewCollectionView?.showsVerticalScrollIndicator = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cellWidth = max(contentView.frame.width, 350) 
        reviewCollectionView.frame = CGRect(x: 0, y: 35, width: cellWidth, height: 260)
        reviewCollectionView.isHidden = false
        reviewCollectionView.alpha = 1.0
        reviewCollectionView.clipsToBounds = false
    }

    func configure(_ reviewDetailsVM : ReviewDetailsViewModel) {
        self.reviewDetailsVM = reviewDetailsVM
        
        setupCollectionView()
        
        reviewCollectionView.backgroundColor = UIColor.clear
        reviewCollectionView.layer.borderWidth = 0
        reviewCollectionView.layer.borderColor = UIColor.clear.cgColor
        reviewCollectionView.isHidden = false
        reviewCollectionView.alpha = 1.0
        
        let cellWidth = max(self.frame.width, self.contentView.frame.width, 350)
        reviewCollectionView.frame = CGRect(x: 0, y: 35, width: cellWidth, height: 260)
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        reviewCollectionView.setNeedsLayout()
        reviewCollectionView.layoutIfNeeded()
        
        DispatchQueue.main.async {
            let finalWidth = max(self.contentView.frame.width, 350)
            self.reviewCollectionView.frame = CGRect(x: 0, y: 35, width: finalWidth, height: 260)
            self.reviewCollectionView.reloadData()
        }
    }
}

extension ReviewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func setupCollectionView() {
        let nib: UINib = UINib(nibName: "ReviewCollectionViewCell", bundle: nil)
        reviewCollectionView.register(nib, forCellWithReuseIdentifier: "ReviewCollectionViewCell")
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self

        if let layout = reviewCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize = PresetSizeValue.reviewCollectionViewItemSize
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = reviewDetailsVM?.numberOfReviews() ?? 0
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: ReviewCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionViewCell", for: indexPath) as? ReviewCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = UIColor.systemGray6
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        guard let reviewVM = reviewDetailsVM?.getReviewViewModel(at: indexPath.row) else {
            return cell
        }
        
        cell.configure(reviewVM)
        
        return cell
    }
    
    private func reloadReviewView() {
        self.reviewCollectionView.reloadData()
    }
}

extension ReviewTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = PresetSizeValue.reviewCollectionViewItemSize
        return size
    }
}

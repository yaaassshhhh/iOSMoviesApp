//
//  SimilarCollectionViewCell.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 29/07/25.
//

import UIKit


protocol SimilarCollectionViewCellDelegate: MovieCardTableViewCellDelegate {
    func updateProfilePicFromPlaceholder(named: String)
}

final class SimilarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    private var similarVM : SimilarViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureState(_ similarData: SimilarViewModel?) {
        
        guard let similarData: SimilarViewModel = similarData else {return}
        self.similarVM = similarData
        
        setupTitle()
        setupPoster()
    }
    
    private func setupTitle() {
        guard let movieTitle = similarVM?.title else {return}
        title.text = movieTitle
        title.setLinesByWord()
    }
    
    
    private func setupPoster() {
        similarVM?.loadCastImage(delegate: self)
        moviePoster?.layer.cornerRadius = 10
        moviePoster?.clipsToBounds = true
    }
}

extension SimilarCollectionViewCell : SimilarCollectionViewCellDelegate {
    
    func updatePoster(with imageData: Data, cacheKey: NSString) {
        if let image: UIImage = UIImage(data: imageData) {
            self.setupCache(image, cacheKey)
            DispatchQueue.main.async {
                self.moviePoster.image = image
            }
        }
    }
    
    func updateProfilePicFromPlaceholder(named defaultPic: String) {
        self.moviePoster.image = UIImage(named: defaultPic)
    }
    
    func updatePosterFromCache(with image: UIImage) {
        DispatchQueue.main.async {
            self.moviePoster.image = image
        }
    }
    
    func setupCache(_ image : UIImage, _ cacheKey : NSString) {
        ImageCache.shared.setObject(image, forKey: cacheKey)
    }
}


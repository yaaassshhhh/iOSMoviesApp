//
//  CastCollectionViewCell.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 11/07/25.
//

import UIKit
protocol CastCollectionViewCellDelegate: AnyObject {
    func updateProfilePic(with imageData : Data, cacheKey: NSString)
    func updateProfilePicFromCache(with image: UIImage)
}
class CastCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var realName: UILabel!
    @IBOutlet weak var fictionalName: UILabel!
    @IBOutlet weak var castImage: UIImageView!
    private weak var delegate: CastDetailsTableViewCellDelegate?
    private var castVM : CastViewModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureState(_ castData: CastViewModel?, delegate : CastDetailsTableViewCellDelegate?){
        guard let delegate = delegate else {return}
        guard let castData = castData else {return}
        self.castVM = castData
        setupRealName()
        setupFictionalName()
        
    }
    private func setupRealName() {
        realName.text = castVM.realName
        realName.numberOfLines = 0
        realName.lineBreakMode = .byWordWrapping
    }
    private func setupFictionalName() {
        fictionalName.text = castVM.fictionalName
        fictionalName.numberOfLines = 0
        fictionalName.lineBreakMode = .byWordWrapping
    }
    func setupPoster() {
        castVM.loadCastImage(delegate: self)
    }
}

extension CastCollectionViewCell : CastCollectionViewCellDelegate {
        func updateProfilePic(with imageData: Data, cacheKey: NSString) {
            if let image = UIImage(data: imageData) {
                self.setupCache(image, cacheKey)
                DispatchQueue.main.async {
                    self.castImage.image = image
                }
            }
        }
        
        func updateProfilePicFromCache(with image: UIImage) {
            DispatchQueue.main.async {
                self.castImage.image = image
            }
        }
    func setupCache(_ image : UIImage, _ cacheKey : NSString){
        ImageCache.shared.setObject(image, forKey: cacheKey)
    }
}

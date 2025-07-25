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
    func updateProfilePicFromPlaceholder(named: String)
}

final class CastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var realName: UILabel!
    @IBOutlet weak var fictionalName: UILabel!
    @IBOutlet weak var castImage: UIImageView!
    private var castVM : CastViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureState(_ castData: CastViewModel?) {
        
        guard let castData: CastViewModel = castData else {return}
        self.castVM = castData
        
        setupRealName()
        setupFictionalName()
        setupPoster()
    }
    
    private func setupRealName() {
        guard let actorName = castVM?.realName else {return}
        realName.text = actorName
        realName.setLinesByWord()
    }
    
    private func setupFictionalName() {
        guard let charName = castVM?.fictionalName else {return}
        fictionalName.text = charName
        fictionalName.setLinesByWord()
    }
    
    func setupPoster() {
        castImage.setRounded()
        castVM?.loadCastImage(delegate: self)
    }
}

extension CastCollectionViewCell : CastCollectionViewCellDelegate {
    
    func updateProfilePic(with imageData: Data, cacheKey: NSString) {
        if let image: UIImage = UIImage(data: imageData) {
            self.setupCache(image, cacheKey)
            DispatchQueue.main.async {
                self.castImage.image = image
                self.castImage.setRounded()
            }
        }
    }
    
    func updateProfilePicFromPlaceholder(named defaultPic: String) {
        self.castImage.image = UIImage(named: defaultPic)
    }
    
    func updateProfilePicFromCache(with image: UIImage) {
        DispatchQueue.main.async {
            self.castImage.image = image
            self.castImage.setRounded()
        }
    }
    
    func setupCache(_ image : UIImage, _ cacheKey : NSString) {
        ImageCache.shared.setObject(image, forKey: cacheKey)
    }
}


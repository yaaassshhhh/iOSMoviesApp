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
class CastCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var realName: UILabel!
    @IBOutlet weak var fictionalName: UILabel!
    @IBOutlet weak var castImage: UIImageView!
    private var castVM : CastViewModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureState(_ castData: CastViewModel?){

        guard let castData = castData else {return}
        self.castVM = castData

        setupRealName()
        setupFictionalName()
        setupPoster()
        print("\n Individual Cast inside Cast Collection View cell : \n \(castVM.realName) \n \(castVM.fictionalName)")
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
    func updateProfilePicFromPlaceholder(named defaultPic: String) {
        self.castImage.image = UIImage(named: defaultPic)
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

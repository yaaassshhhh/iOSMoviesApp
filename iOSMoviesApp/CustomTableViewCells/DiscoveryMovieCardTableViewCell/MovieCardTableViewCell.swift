//
//  MovieCardTableViewCell.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 08/07/25.
//

import UIKit

protocol MovieCardTableViewCellDelegate: AnyObject {
    func updatePoster(with imageData : Data, cacheKey: NSString)
    func updatePosterFromCache(with image: UIImage)
}

class MovieCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    private var movieVM: MovieViewModel!
    private weak var delegate: DiscoveryPageViewControllerDelegate?
    private var indexPath: IndexPath!
    
    @IBAction func movieSelected(_ sender: Any) {
        delegate?.navigateToDetails(for: self.indexPath)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        moviePoster.image = nil
        movieTitle.text = nil
        movieReleaseDate.text = nil
        movieDescription.text = nil
    }
    
    func configureState(with movieVM: MovieViewModel, delegate: DiscoveryPageViewControllerDelegate?, indexPath : IndexPath) {
        self.movieVM = movieVM
        self.delegate = delegate
        self.indexPath = indexPath
        
        setupPoster()
        setupTitle()
        setupReleaseDate()
        setupDescription()
    }
    
    func setupTitle() {
        movieTitle.text = movieVM.title
        movieTitle.setLinesByWord()
    }
    
    func setupReleaseDate() {
        movieReleaseDate.text = movieVM.releaseDate
        movieReleaseDate.setLinesByWord()
    }
    
    func setupDescription() {
        movieDescription.text = movieVM.description
        movieDescription.setLinesByTail()
    }
    
    func setupPoster() {
        movieVM.loadImage(delegate: self)
    }
}

extension MovieCardTableViewCell : MovieCardTableViewCellDelegate {
    func updatePoster(with imageData: Data, cacheKey : NSString ) {
        if let image: UIImage = UIImage(data: imageData) {
            self.setUpCache(image, cacheKey)
            DispatchQueue.main.async {
                self.moviePoster.image = image
            }
        }
    }
    
    func updatePosterFromCache(with image: UIImage) {
        DispatchQueue.main.async {
            self.moviePoster.image = image
        }
    }
    
    func setUpCache(_ image : UIImage, _ cacheKey : NSString){
        ImageCache.shared.setObject(image, forKey: cacheKey)
    }
}

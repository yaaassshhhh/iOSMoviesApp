//
//  MovieCardTableViewCell.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 08/07/25.
//

import UIKit

protocol MovieCardTableViewCellDelegate: AnyObject {
    func updatePoster(with image : Data, cacheKey: NSString)
    func updatePosterFromCache(with image: UIImage)
}

class MovieCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    private var movieVM: MovieViewModel!
    
    @IBAction func movieSelected(_ sender: Any) {
        print("Movie Selected")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        moviePoster.image = nil
        movieTitle.text = nil
        movieReleaseDate.text = nil
        movieDescription.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureState(with movieVM: MovieViewModel) {
        self.movieVM = movieVM
        setupPoster()
        setupTitle()
        setupReleaseDate()
        setupDescription()
    }
    
    func setupTitle() {
        movieTitle.text = movieVM.title
        movieTitle.numberOfLines = 0
        movieTitle.lineBreakMode = .byWordWrapping
    }
    func setupReleaseDate() {
        movieReleaseDate.text = movieVM.releaseDate
        movieReleaseDate.numberOfLines = 0
        movieReleaseDate.lineBreakMode = .byWordWrapping
    }
    func setupDescription() {
        movieDescription.text = movieVM.description
        movieDescription.numberOfLines = 0
        movieDescription.lineBreakMode = .byWordWrapping
    }
    func setupPoster() {
        movieVM.loadImage(delegate: self)
    }
}

extension MovieCardTableViewCell : MovieCardTableViewCellDelegate {
    func updatePoster(with imageData: Data, cacheKey : NSString ) {
        if let image = UIImage(data: imageData) {
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

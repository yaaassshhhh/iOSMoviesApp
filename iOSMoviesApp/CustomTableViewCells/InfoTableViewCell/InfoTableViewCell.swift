//
//  InfoTableViewCell.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 16/07/25.
//

import UIKit

final class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieVotes: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var MoviePoster: UIImageView!
    
    private var infoVM: InfoViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func configureState(with infoVM: InfoViewModel?) {
        guard let infoVM: InfoViewModel = infoVM else { return }
        self.infoVM = infoVM
        
        setupMoviePoster()
        setupMovieName()
        setupMovieVotes()
        setupMovieDescription()
        setupMovieGenre()
        setupMovieRating()
    }
    
    private func setupMoviePoster() {
        infoVM?.loadMoviePoster(delegate: self)
    }
    
    private func setupMovieDescription() {
        movieDescription.text = infoVM?.description ?? ""
        movieDescription.setLinesByTail()
    }
    
    private func setupMovieName() {
        movieName.text = infoVM?.movieName ?? ""
        movieName.setLinesByWord()
    }
    
    private func setupMovieRating() {
        movieRating.text = infoVM?.rating ?? ""
        movieRating.setLinesByWord()
    }
    
    private func setupMovieVotes() {
        movieVotes.text = infoVM?.votes ?? ""
        movieVotes.setLinesByWord()
    }
    
    private func setupMovieGenre() {
        movieGenre.text = infoVM?.genres ?? ""
        movieGenre.setLinesByWord()
    }
}

extension InfoTableViewCell : MovieCardTableViewCellDelegate {
    
    func updatePoster(with imageData: Data, cacheKey: NSString) {
        if let image: UIImage = UIImage(data: imageData) {
            self.setUpCache(image, cacheKey)
            DispatchQueue.main.async {
                self.MoviePoster.image = image
            }
        }
    }
    
    func updatePosterFromCache(with image: UIImage) {
        DispatchQueue.main.async {
            self.MoviePoster.image = image
        }
    }
    
    func setUpCache(_ image : UIImage, _ cacheKey : NSString){
        ImageCache.shared.setObject(image, forKey: cacheKey)
    }
}

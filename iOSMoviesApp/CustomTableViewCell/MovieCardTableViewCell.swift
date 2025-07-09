//
//  MovieCardTableViewCell.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 08/07/25.
//

import UIKit

class MovieCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    @IBAction func movieSelected(_ sender: Any) {
        print("Movie Selected")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

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
    
    func configureState(with movie: MovieViewModel) {
        movieTitle.text = movie.title
//        movieReleaseDate.text = "Release: \(movie.releaseDate ?? "N/A")"
//        movieDescription.text = movie.overview

        if let url = URL(string: movie.posterURL) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.moviePoster.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
}

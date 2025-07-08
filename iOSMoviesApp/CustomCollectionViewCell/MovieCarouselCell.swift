import UIKit

class MovieCarouselCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true
    }

    func configure(with movie: MovieViewModel) {
//        if let url = URL(string: movie.posterURL) {
//            URLSession.shared.dataTask(with: url) { data, _, _ in
//                if let data = data {
//                    DispatchQueue.main.async {
//                        self.posterImageView.image = UIImage(data: data)
//                    }
//                }
//            }.resume()
//        }
    }
}

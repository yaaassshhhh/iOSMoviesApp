//
//  MovieCardTableViewCell.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 08/07/25.
//

import UIKit

class MovieCardTableViewCell: UITableViewCell {
    

    @IBOutlet weak var movieTwoSubtitle: UILabel!
    @IBOutlet weak var movieTwoTitle: UILabel!
    @IBOutlet weak var movieOneSubtitle: UILabel!
    @IBOutlet weak var movieOneTitle: UILabel!
    
    @IBAction func showMovie(_ sender: UIButton) {
        
    }
    
    
    @IBOutlet weak var movieTwoImg: UIImageView!
    @IBOutlet weak var movieOneImg: UIImageView!
    @IBAction func movieSelected(_ sender: Any) {
        print("Movie Selected")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureState(for movieVM : MovieViewModel){
        
    }
}

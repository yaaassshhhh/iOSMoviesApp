//
//  CastDetailsTableViewCell.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 11/07/25.
//

import UIKit

protocol CastDetailsTableViewCellDelegate: AnyObject {
    func reloadCollectionView()
}
class CastDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var castCollectionView: UICollectionView!
    private weak var delegate : DetailsScreenViewControllerDelegate?
    private var castDetailsVM: [CastViewModel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    func configureState (_ castDetailsVM: [CastViewModel], delegate : DetailsScreenViewControllerDelegate ){
        self.delegate = delegate
        self.castDetailsVM = castDetailsVM
    }
}

extension CastDetailsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func setupCollectionView() {
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        delegate?.numberOfCasts() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as? CastCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureState(delegate?.getCastVM(at: indexPath.row), delegate : self)
        return cell
    }
}

extension CastDetailsTableViewCell: CastDetailsTableViewCellDelegate {
    func reloadCollectionView() {
        self.castCollectionView.reloadData()
    }
}

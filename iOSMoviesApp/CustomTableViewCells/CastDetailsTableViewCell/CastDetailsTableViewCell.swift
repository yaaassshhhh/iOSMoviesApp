//
//  CastDetailsTableViewCell.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 11/07/25.
//

import UIKit

class CastDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var castCollectionView: UICollectionView!
    private var castDetailsVM : CastDetailsViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    func configureState (_ castDetailsVM: CastDetailsViewModel) {
        self.castDetailsVM = castDetailsVM
        self.reloadCollectionView()
    }
}

extension CastDetailsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func setupCollectionView() {
        let nib = UINib(nibName: "CastCollectionViewCell", bundle: nil)
        castCollectionView.register(nib, forCellWithReuseIdentifier: "CastCollectionViewCell")
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        castDetailsVM?.numberOfCasts() ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as? CastCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureState(castDetailsVM?.getCastViewModel(at: indexPath.row))

        return cell
    }
    private func reloadCollectionView() {
        self.castCollectionView.reloadData()
    }
}

extension CastDetailsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
}


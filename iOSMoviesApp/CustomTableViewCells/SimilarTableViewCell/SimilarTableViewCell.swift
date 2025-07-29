//
//  SimilarTableViewCell.swift
//  iOSMoviesApp
//
//  Created by Tarang Sultania on 29/07/25.
//
import UIKit

protocol SimilarMovieSelectionDelegate: AnyObject {
    func didSelectSimilarMovie(with movieId: Int)
}

final class SimilarTableViewCell: UITableViewCell {

    @IBOutlet weak var similarCollectionView: UICollectionView!
    
    weak var delegate: SimilarMovieSelectionDelegate?
    
    private var similarDetailsVM : SimilarDetailsViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        self.selectionStyle = .none
    }

    func configureState (_ similarDetailsVM: SimilarDetailsViewModel) {
        self.similarDetailsVM = similarDetailsVM
        self.reloadCollectionView()
    }
}

extension SimilarTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    private func setupCollectionView() {
        
        let nib: UINib = UINib(nibName: "SimilarCollectionViewCell", bundle: nil)
        
        similarCollectionView.register(nib, forCellWithReuseIdentifier: "SimilarCollectionViewCell")
        similarCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        similarCollectionView.dataSource = self
        similarCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        similarDetailsVM?.numberOfSimilar() ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: SimilarCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarCollectionViewCell", for: indexPath) as? SimilarCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureState(similarDetailsVM?.getSimilarViewModel(at: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let similarDetailsVM = self.similarDetailsVM else { return }
        let selectedSimilarVM = similarDetailsVM.getSimilarViewModel(at: indexPath.row)
        let movieId = selectedSimilarVM.id
        delegate?.didSelectSimilarMovie(with: movieId)
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    private func reloadCollectionView() {
        self.similarCollectionView.reloadData()
    }
}

extension SimilarTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return PresetSizeValue.similarCollectionViewItemSize
    }
}

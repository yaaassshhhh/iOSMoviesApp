//
//  DetailsScreenViewModel.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 11/07/25.
//

import Foundation

class DetailsScreenViewModel {
    
    var movie : MovieViewModel? = nil
    var info : InfoViewModel? = nil
    var casts : CastDetailsViewModel? = nil
    private weak var delegate : ViewControllerTableReloadDelegate?
    
    init(delegate: ViewControllerTableReloadDelegate? = nil) {
        self.delegate = delegate
    }
}

extension DetailsScreenViewModel {
    
    func fetchCastDetails() {
        guard let delegate = self.delegate, let movie = self.movie else {
            return
        }
        let result : Result<Resource<CreditsResponse>, NetworkError> = CreditsResponse.resource(id: movie.id)
        switch result {
        case .success(let resource):
            WebService().load(resource: resource) { result in
                switch result {
                case .success(let castData) :
                    self.storeCastData(castData)
                    delegate.reloadTableData()
                case .failure(let error) :
                    print("Error fetching data : \(error)")
                }
            }
        case .failure(let error):
            print(error)
        }
        
    }
    
    private func storeCastData (_ castData : CreditsResponse) {
        let castVMs: [CastViewModel] = castData.results.map({
            CastViewModel(cast: $0)
        })
        self.casts = CastDetailsViewModel(castViewModels: castVMs)
    }
    
    func numberOfRows() -> Int {
        return 4
    }
    
    func getAllCastViewModel() -> CastDetailsViewModel {
        guard let casts = self.casts else {
            return CastDetailsViewModel(castViewModels: [])
        }
        return casts
    }
    func setCellHeight(_ index: Int) -> CGFloat {
        switch index {
        case 0:
            return PresetSizeValue.infoCellHeight
        case 2:
            return PresetSizeValue.castCellHeight
        default:
            return 0
        }
    }
}

extension DetailsScreenViewModel {
    
    func fetchMovieInfo() {
        guard let delegate: ViewControllerTableReloadDelegate = self.delegate, let movie: MovieViewModel = self.movie else {
            return
        }
        let result : Result<Resource<Info>, NetworkError> = Info.resource(id: movie.id)
        switch result {
        case .success(let resource):
            WebService().load(resource : resource ) { result in
                switch result {
                    
                case .success(let movieInfo) :
                    self.storeMovieInfo(movieInfo)
                    delegate.reloadTableData()
                    
                case.failure(let error) :
                    print("Error in fetching Movie Info - \(error)")
                }
            }
        case .failure(let error):
            print("Error in fetching Movie Info Resource - \(error)")
        }
    }
    
    private func storeMovieInfo(_ movieInfo: Info) {
        self.info = InfoViewModel(info: movieInfo)
    }
    
    func getMovieInfo() -> InfoViewModel? {
        guard let info: InfoViewModel = self.info else {
            return nil
        }
        return info
    }
}

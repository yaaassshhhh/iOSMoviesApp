//
//  DetailsScreenViewModel.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 11/07/25.
//

class DetailsScreenViewModel {
    var movie : MovieViewModel? = nil
    var casts : CastDetailsViewModel? = nil
    private weak var delegate : DetailsScreenViewControllerDelegate?
    
    init(delegate: DetailsScreenViewControllerDelegate? = nil) {
        self.delegate = delegate
    }
}

extension DetailsScreenViewModel {
    func fetchCastDetails() {
        guard let delegate = self.delegate, let movie = self.movie else {
            return
        }
        WebService().load(resource: CreditsResponse.resource(id : movie.id)) { result in
            switch result {
            case .success(let castData) :
                self.storeCastData(castData)
                delegate.reloadTableData()
            case .failure(let error) :
                print("Error fetching data : \(error)")
            }
        }
    }
    private func storeCastData (_ castData : CreditsResponse) {
        let castVMs = castData.results.map({
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
}


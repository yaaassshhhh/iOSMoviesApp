//
//  DetailsScreenViewModel.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 11/07/25.
//

class DetailsScreenViewModel {
    var casts : [CastViewModel] = []
    private weak var delegate : DetailsScreenViewControllerDelegate?
}
extension DetailsScreenViewModel {
    func fetchCastDetails(for movie_id : Int, delegate : DetailsScreenViewControllerDelegate?){
        //*** TBD --> INITIALIZE DELEGATE SEPERATELY SINCE IT WILL BE USED IN DIFFERENT API CALL ***
        guard let delegate = delegate else {
            return
        }
        self.delegate = delegate
        WebService().load(resource: CreditsResponse.resource(id : movie_id)){ result in
            switch result {
            case .success(let castData) :
                self.storeCastData(castData)
                self.delegate?.reloadTableData()
            case .failure(let error) :
                print("Error fetching data : \(error)")
            }
        }
    }
    private func storeCastData (_ castData : CreditsResponse) {
        self.casts = castData.results.map({
            CastViewModel(cast: $0)
        })
    }
    
    func getCastViewModel(at index : Int) -> CastViewModel {
        return self.casts[index]
    }
    
    func numberOfRows() -> Int {
        return 4
    }
    func getNumberOfCasts() -> Int{
        return self.casts.count
    }
    func getAllCastViewModel() -> [CastViewModel]{
        return self.casts
    }
}


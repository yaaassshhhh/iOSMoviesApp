//
//  DetailsScreenViewModel.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 11/07/25.
//

class DetailsScreenViewModel {
    var casts : [castViewModel] = []
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
                print("cast - \(castData)")
//                self.delegate?.reloadTableView()
            case .failure(let error) :
                print("Error fetching data : \(error)")
            }
        }
    }
    private func storeCastData (_ castData : CreditsResponse) {
        self.casts = castData.results.map({
            castViewModel(cast: $0)
        })
    }
    
    func getCastViewModel(at index : Int) -> castViewModel {
        return self.casts[index]
    }
    
    func numberOfRows() -> Int {
        return 4
    }
}


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
}
struct castViewModel {
    var cast : Cast
    var posterBaseURL: String = "https://image.tmdb.org/t/p/w92"
    init(cast : Cast){
        self.cast = cast
    }
}
extension castViewModel : Identifiable {
    var id : Int {
        return self.cast.id
    }
    var posterPath : String {
        return self.posterBaseURL + self.cast.posterPath
    }
    var realName : String {
        return self.cast.realName
    }
    var fictionalName : String {
        return self.cast.fictionalName
    }
    
//    func loadCastImage(delegate: castCollectionViewCellDelegate?) {
//        guard let delegate = delegate else { return }
//        guard let imageURL = URL(string: self.posterPath) else { return }
//        let cacheKey = NSString(string: self.posterPath)
//        
//        if let cachedImage = CastImageCache.shared.object(forKey: cacheKey) {
//            DispatchQueue.main.async {
//                delegate.updateCastPosterFromCache(with: cachedImage)
//            }
//            return
//        }
//        
//        DispatchQueue.global(qos: .userInitiated).async {
//            guard let imageData = try? Data(contentsOf: imageURL) else { return }
//            delegate.updateCastPoster(with: imageData, cacheKey: cacheKey)
//        }
//    }
}

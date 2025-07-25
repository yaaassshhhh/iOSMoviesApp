//
//  ListResponseJSON.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 08/07/25.
//

import Foundation

struct ListResponseJSON : Decodable {
    var results : [Movie]
    
    enum CodingKeys : String, CodingKey {
        case results = "results"
    }
}

extension ListResponseJSON {
    static func resource() -> Result<Resource<ListResponseJSON>, NetworkError>  {
        guard let movieListURL = URL(string : "https://api.themoviedb.org/3/discover/movie") else {
            return .failure(.urlError)
        }
        let resource = Resource<ListResponseJSON>(url : movieListURL, parse : { data in
            let decoded = try? JSONDecoder().decode(ListResponseJSON.self, from: data)
            return decoded
        })
        return .success(resource)
    }
}

//
//  WebService.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 08/07/25.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
    case invalidResponse
    case encodingError
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T> {
    var url: URL
    var parse: (Data) -> T?
    var body: Data?
    var method : HttpMethod = .get
}

final class WebService {
    func load<T>(resource : Resource<T>, completion: @escaping (Result<T, NetworkError>)-> Void) {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.method.rawValue
        
        if let body = resource.body {
            request.httpBody = body
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            let result = resource.parse(data)
            
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

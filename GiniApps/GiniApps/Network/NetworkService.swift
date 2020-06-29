//
//  NetworkService.swift
//  GiniApps
//
//  Created by niv ben-porath on 29/06/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

enum NetworkError : Error {
    case networkError(errorMessage : String)
    case invalidResponse(errorMessage : String)
    case invalidData
    case jsonError(error : Error)
}

class NetworkService {
    func makeNetworkCall(for url : URL,with completion : @escaping (Result<Data,NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let networkError = error {
                //we have an error in the network call
                completion(.failure(.networkError(errorMessage: "The network error was \(networkError)")))
            }
            
            guard let networkResponse = response as? HTTPURLResponse, networkResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse(errorMessage: "the response was \(String(describing: response))")))
                return
            }
            
            guard let receivedData = data else {
                completion(.failure(.invalidData))
                return
            }
            
            completion(.success(receivedData))
        }
        
        task.resume()
    }
}

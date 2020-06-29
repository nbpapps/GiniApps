
//
//  DataFecthing.swift
//  GiniApps
//
//  Created by niv ben-porath on 29/06/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

struct DataFetching {
    func requestArray(at url : URL, with completion : @escaping (Result<Numbers,NetworkError>) -> Void) {
        let networkService = NetworkService()
        networkService.makeNetworkCall(for: url) { (result) in
            switch result {
            case .success(let data):
                let parser = JsonParser(data: data)
                let parsedData : Result<Numbers,JsonError> = parser.decode()
                switch parsedData {
                case .success(let numbers):
                    completion(.success(numbers))
                case .failure(let error):
                    completion(.failure(.jsonError(error: error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

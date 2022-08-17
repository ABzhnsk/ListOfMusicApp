//
//  NetworkRequest.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 17.08.2022.
//

import Foundation

class NetworkRequest {
    static let shared = NetworkRequest()
    
    private init() {}
    
    func requestData(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, responce, err in
            DispatchQueue.main.async {
                if let error = err {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        .resume()
    }
}

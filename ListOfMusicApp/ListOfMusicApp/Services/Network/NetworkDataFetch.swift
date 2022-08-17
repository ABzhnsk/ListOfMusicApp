//
//  NetworkDataFetch.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 17.08.2022.
//

import Foundation

class NetworkDataFetch {
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    func fetchAlbum(urlString: String, responce: @escaping (AlbumModel?, Error?) -> Void) {
        NetworkRequest.shared.requestData(urlString: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let jsonAlbum = try JSONDecoder().decode(AlbumModel.self, from: data)
                    responce(jsonAlbum, nil)
                } catch let jsonError {
                    print("Failed to decode json \(jsonError.localizedDescription)")
                }
            case .failure(let err):
                print("Error request: \(err.localizedDescription)")
                responce(nil, err)
            }
        }
    }
    
    func fetchSong(urlString: String, responce: @escaping (SongsModel?, Error?) -> Void) {
        NetworkRequest.shared.requestData(urlString: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let jsonAlbum = try JSONDecoder().decode(SongsModel.self, from: data)
                    responce(jsonAlbum, nil)
                } catch let jsonError {
                    print("Failed to decode json \(jsonError.localizedDescription)")
                }
            case .failure(let err):
                print("Error request: \(err.localizedDescription)")
                responce(nil, err)
            }
        }
    }
}

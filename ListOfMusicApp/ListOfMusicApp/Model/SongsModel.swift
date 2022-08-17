//
//  SongsModel.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 17.08.2022.
//

import Foundation

struct SongsModel: Decodable {
    let results: [Song]
}

struct Song: Decodable {
    let trackName: String?
}

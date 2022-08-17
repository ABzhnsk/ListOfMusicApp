//
//  MusicListViewProtocol.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 16.08.2022.
//

import Foundation

enum MusicListViewNavigation {
    case exit
    case profile
    case details(Album)
}

protocol MusicListViewProtocol {
    func move(to: MusicListViewNavigation)
    func showMusicList(albums: [Album]?)
    func getAlbum(at index: Int) -> Album
    func showLogoutErrorDialog(message: String)
    func showSearchError()
}

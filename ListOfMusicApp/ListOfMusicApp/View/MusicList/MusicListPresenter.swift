//
//  MusicListPresenter.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 16.08.2022.
//

import Foundation
import UIKit

class MusicListPresenter {
    let view: MusicListViewProtocol
    let auth: AuthProtocol
    var albums: [Album]?
    
    init(view: MusicListViewProtocol, auth: AuthProtocol, albums: [Album]?) {
        self.view = view
        self.auth = auth
        self.albums = albums
    }
    
    func didChangeSearch(albumName: String) {
        let urlString = "https://itunes.apple.com/search?term=\(albumName)"
        
        NetworkDataFetch.shared.fetchAlbum(urlString: urlString) { [weak self] album, error in
            if error == nil {
                guard let albumData = album else { return }
                
                if albumData.results != [] {
                    let sortedAlbums = albumData.results.sorted { firstItem, secondItem in
                        return firstItem.collectionName.compare(secondItem.collectionName) == ComparisonResult.orderedAscending
                    }
                    self?.albums = sortedAlbums
                } else {
                    self?.view.showSearchError()
                }
            } else {
                print(error!.localizedDescription)
            }
            
            self?.view.showMusicList(albums: self?.albums)
        }
    }
    
    func selectRow(at index: Int) {
        let album = view.getAlbum(at: index)
        view.move(to: .details(album))
    }
    
    func tapProfileButton() {
        self.view.move(to: .profile)
    }
    
    func tapExitButton() {
        if auth.logout() {
            view.move(to: .exit)
        } else {
            view.showLogoutErrorDialog(message: "Failed to log out.")
        }
    }
}

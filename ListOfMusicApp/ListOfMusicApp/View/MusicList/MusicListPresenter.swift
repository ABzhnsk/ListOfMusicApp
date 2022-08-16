//
//  MusicListPresenter.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 16.08.2022.
//

import Foundation

class MusicListPresenter {
    let view: MusicListViewProtocol
    let auth: AuthProtocol
    
    init(view: MusicListViewProtocol, auth: AuthProtocol) {
        self.view = view
        self.auth = auth
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

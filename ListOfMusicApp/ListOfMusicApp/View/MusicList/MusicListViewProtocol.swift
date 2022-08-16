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
    case details
}

protocol MusicListViewProtocol {
    func move(to: MusicListViewNavigation)
}

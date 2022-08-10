//
//  SettingsUI.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 10.08.2022.
//

import Foundation
import UIKit

class SettingsUI {
    static func styleFilledButton (_ button: UIButton) {
        button.backgroundColor = UIColor.init(red: 102/255, green: 20/255, blue: 152/255, alpha: 1)
        button.layer.cornerRadius = 20.0
        button.tintColor = UIColor.white
    }
}

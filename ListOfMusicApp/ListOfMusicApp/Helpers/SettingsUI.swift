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
    
    static func styleTextField(_ textField: [UITextField]) {
        for textField in textField {
            textField.layer.borderWidth = 1
            textField.layer.cornerRadius = 5
            textField.layer.borderColor = UIColor.purpureColor.cgColor
            textField.borderStyle = .roundedRect
        }
    }
    
    static func styleValidLabel(_ label: [UILabel]) {
        for label in label {
            label.alpha = 0
            label.textColor = UIColor.requiredColor
            label.font = UIFont.systemFont(ofSize: 12)
        }
    }
}

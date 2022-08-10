//
//  SignInViewController.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 10.08.2022.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }

}

extension SignInViewController {
    func setUpElements() {
        errorLabel.alpha = 0
        SettingsUI.styleFilledButton(signInButton)
    }
}

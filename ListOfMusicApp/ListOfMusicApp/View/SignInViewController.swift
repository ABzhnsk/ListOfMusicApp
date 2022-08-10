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
    
    
    @IBAction func signInTapped(_ sender: Any) {
        
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        let signUpViewController = SignUpViewController()
        self.present(signUpViewController, animated: true)
    }
    
}

extension SignInViewController {
    private func setUpElements() {
        errorLabel.alpha = 0
        SettingsUI.styleFilledButton(signInButton)
    }
}

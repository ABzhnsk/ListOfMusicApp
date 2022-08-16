//
//  SignInViewController.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 10.08.2022.
//

import UIKit

class SignInViewController: UIViewController {
    var presenter: SignInPresenter!
    
    //MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        addObserverKeyboard()
        addTapRecognizer()
        
        presenter = SignInPresenter(view: self, auth: Authentication())
        presenter.show()
    }
    
    //MARK: - IBActions
    @IBAction func signInTapped(_ sender: Any) {
        presenter.tapSignInButton()
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        let signUpViewController = SignUpViewController()
        self.present(signUpViewController, animated: true)
    }
    
    //MARK: - deinit
    deinit {
        removeObserverKeyboard()
    }
}

extension SignInViewController {
    
    //MARK: - Set up UI elements
    private func setUpElements() {
        SettingsUI.styleFilledButton(signInButton)
    }
    
    //MARK: - Add UIRecognizer and Observer
    private func addTapRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.view.addGestureRecognizer(tapRecognizer)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    private func addObserverKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func removeObserverKeyboard() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    @objc private func onTap() {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardHeight = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight / 2)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }
}

// MARK: - SignIn logic
extension SignInViewController: SignInViewProtocol {
    var email: String {
        get { return emailTextField.text ?? "" }
        set { emailTextField.text = newValue}
    }
    
    var password: String {
        get { return passwordTextField.text ?? "" }
        set { passwordTextField.text = newValue }
    }
    
    func move(to: SignInViewNavigation) {
        switch to {
        case .music:
            performSegue(withIdentifier: "toMusicList", sender: nil)
        }
    }
    
    func showSignInError(message: String) {
        AlertBuilder()
            .title("Error")
            .message(message)
            .action("OK")
            .show(self, animated: true)
    }
}

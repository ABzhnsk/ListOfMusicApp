//
//  SignUpViewController.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 10.08.2022.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.textColor = UIColor.purpureColor
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        return textField
    }()
    
    private let firstNameValidLabel = UILabel()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        return textField
    }()
    
    private let lastNameValidLabel = UILabel()
    
    private let birthdayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Birthday"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let ageValidLabel = UILabel()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let phoneValidLabel = UILabel()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        return textField
    }()
    
    private let emailValidLabel = UILabel()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        return textField
    }()
    
    private let passwordValidLabel = UILabel()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitle("Sign Up", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.tintColor = .black
        return datePicker
    }()
    
    private var elementsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setConstraint()
        setUpDelegate()
        addObserverKeyboard()
        addTapRecognizer()
    }
    
    deinit {
        removeObserverKeyboard()
    }
}

extension SignUpViewController {    
    private func setUpViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        elementsStackView = UIStackView(arrangedSubviews: [firstNameTextField,
                                                           firstNameValidLabel,
                                                           lastNameTextField,
                                                           lastNameValidLabel,
                                                           birthdayLabel,
                                                           datePicker,
                                                           ageValidLabel,
                                                           phoneNumberTextField,
                                                           phoneValidLabel,
                                                           emailTextField,
                                                           emailValidLabel,
                                                           passwordTextField,
                                                           passwordValidLabel
                                                          ])
        elementsStackView.axis = .vertical
        elementsStackView.spacing = 10
        elementsStackView.distribution = .fillProportionally
        SettingsUI.styleTextField([firstNameTextField,
                                   lastNameTextField,
                                   phoneNumberTextField,
                                   emailTextField,
                                   passwordTextField
                                  ])
        SettingsUI.styleValidLabel([firstNameValidLabel,
                                    lastNameValidLabel,
                                    ageValidLabel,
                                    phoneValidLabel,
                                    emailValidLabel,
                                    passwordValidLabel
                                   ])
        backgroundView.addSubview(elementsStackView)
        backgroundView.addSubview(signUpLabel)
        SettingsUI.styleFilledButton(signUpButton)
        backgroundView.addSubview(signUpButton)
    }
    
    private func setConstraint() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view)
        }
        backgroundView.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(scrollView)
            make.height.equalTo(view.snp.height)
            make.width.equalTo(view)
        }
        elementsStackView.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel).inset(60)
            make.leading.trailing.equalTo(view).inset(20)
        }
        signUpLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.topMargin.equalTo(backgroundView).offset(20)
        }
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.bottom.equalTo(passwordValidLabel).offset(70)
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
    }
    
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
        scrollView.contentSize = CGSize(width: view.frame.width, height: scrollView.frame.height + 250)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case firstNameTextField: setTextField(textField: firstNameTextField,
                                              label: firstNameValidLabel,
                                              validType: String.ValidTypes.name,
                                              wrongMessage: "Required. Only A-Z characters",
                                              string: string,
                                              range: range)
        case lastNameTextField: setTextField(textField: lastNameTextField,
                                              label: lastNameValidLabel,
                                              validType: String.ValidTypes.name,
                                              wrongMessage: "Required. Only A-Z characters",
                                              string: string,
                                              range: range)
        case emailTextField: setTextField(textField: emailTextField,
                                          label: emailValidLabel,
                                          validType: String.ValidTypes.email,
                                          wrongMessage: "Email is not valid",
                                          string: string,
                                          range: range)
        case passwordTextField: setTextField(textField: passwordTextField,
                                          label: passwordValidLabel,
                                          validType: String.ValidTypes.password,
                                          wrongMessage: "Min: 6 char, 1 upper and lower case, 1 num char",
                                          string: string,
                                          range: range)
        default:
            break
        }
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    private func setUpDelegate() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setTextField(textField: UITextField, label: UILabel, validType: String.ValidTypes, wrongMessage: String, string: String, range: NSRange) {
        
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        textField.text = result
        
        if result.isValid(type: validType) {
            textField.layer.borderColor = UIColor.green.cgColor
            label.alpha = 0
            label.text = ""
        } else {
            textField.layer.borderColor = UIColor.red.cgColor
            label.text = wrongMessage
            label.alpha = 1
        }
    }
    
}

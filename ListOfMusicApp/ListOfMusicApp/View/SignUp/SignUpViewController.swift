//
//  SignUpViewController.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 10.08.2022.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    var presenter: SignUpPresenter!
    
    //MARK: - Private property for UI
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
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(tapSignUp(_:)), for: .touchUpInside)
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
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setConstraint()
        setUpDelegate()
        addObserverKeyboard()
        addTapRecognizer()
        
        presenter = SignUpPresenter(view: self, auth: Authentication(), database: Database())
    }
    
    //MARK: - Deinit
    deinit {
        removeObserverKeyboard()
    }
}

extension SignUpViewController {
    
    //MARK: - Set up UI elements
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
    
    //MARK: - Set up constraints for UI elements
    private func setConstraint() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(self.view)
        }
        backgroundView.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(scrollView)
            make.height.equalTo(self.view.snp.height)
            make.width.equalTo(self.view)
        }
        elementsStackView.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel).inset(60)
            make.leading.trailing.equalTo(self.view).inset(20)
        }
        signUpLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.topMargin.equalTo(backgroundView).offset(20)
        }
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.bottom.equalTo(elementsStackView).offset(70)
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
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
    
    //MARK: - Objc func
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
    
    @objc func tapSignUp(_ sender: UIButton) {
        let firstNameText = firstNameTextField.text ?? ""
        let lastNameText = lastNameTextField.text ?? ""
        let phoneText = phoneNumberTextField.text ?? ""
        let emailText = emailTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""
        
        if firstNameText.isValid(type: .name) &&
            lastNameText.isValid(type: .name) &&
            phoneText.isValid(type: .phone) &&
            emailText.isValid(type: .email) &&
            passwordText.isValid(type: .password) &&
            isAgeValid() == true
        {
            presenter.tapSignUpButton()
        } else {
            showTextFieldError()
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    //MARK: - Check change characters for UITextField
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
        case phoneNumberTextField:
            phoneNumberTextField.text = setPhoneNumberMask(mask: "+X (XXX) XXX-XX-XX",
                                                           string: string,
                                                           range: range)
            
            
        default:
            break
        }
        
        return false
    }
    
    // MARK: - Check resign first responder for UITextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    // MARK: - Set delegate for UITextField
    private func setUpDelegate() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    //MARK: - Settings for UITextField
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
    
    //MARK: - Settings for phone number text field
    private func setPhoneNumberMask(mask: String, string: String, range: NSRange) -> String {
        let text = phoneNumberTextField.text ?? ""
        let phone = (text as NSString).replacingCharacters(in: range, with: string)
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex
        
        for char in mask where index < number.endIndex {
            if char == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(char)
            }
        }
        
        if result.isValid(type: String.ValidTypes.phone) {
            phoneNumberTextField.layer.borderColor = UIColor.green.cgColor
            phoneValidLabel.alpha = 0
            phoneValidLabel.text = ""
        } else {
            phoneNumberTextField.layer.borderColor = UIColor.red.cgColor
            phoneValidLabel.text = "Phone number shoud be +7 (XXX) XXX-XX-XX"
            phoneValidLabel.alpha = 1
        }
        
        return result
    }
    
    //MARK: - Check age
    private func isAgeValid() -> Bool {
        let calendar = NSCalendar.current
        let dateNow = Date()
        let birthday = datePicker.date
        let age = calendar.dateComponents([.year], from: birthday, to: dateNow)
        let ageYear = age.year
        guard let userAge = ageYear else { return false }
        return (userAge < 18 ? false : true)
    }
    
}

extension SignUpViewController: SignUpViewProtocol {
    
    //MARK: - Protocol's properties
    var firstName: String {
        get {
            return firstNameTextField.text ?? ""
        }
        set {
            firstNameTextField.text = newValue
        }
    }
    
    var lastName: String {
        get {
            return lastNameTextField.text ?? ""
        }
        set {
            lastNameTextField.text = newValue
        }
    }
    
    var phoneNumber: String {
        get {
            return phoneNumberTextField.text ?? ""
        }
        set {
            phoneNumberTextField.text = newValue
        }
    }
    
    var age: Date {
        return datePicker.date
    }
    
    var email: String {
        get {
            return emailTextField.text ?? ""
        }
        set {
            emailTextField.text = newValue
        }
    }
    
    var password: String {
        get {
            return passwordTextField.text ?? ""
        }
        set {
            passwordTextField.text = newValue
        }
    }
    
    //MARK: - Create alerts
    func showSuccessDialog() {
        let alert = UIAlertController(title: "Успешно", message: "вы зареганы", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel))
        self.present(alert, animated: true)
    }
    
    func showSignUpError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel))
        self.present(alert, animated: true)
    }
    
    private func showTextFieldError() {
        let alert = UIAlertController(title: "Error", message: "All fields are required", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel))
        self.present(alert, animated: true)
    }
}

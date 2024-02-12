//
//  LoginViewController.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 13/02/24.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var signupLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var passwordTextField: CustomTextField!
    @IBOutlet var emailTextField: CustomTextField!
    @IBOutlet var buttonContinue: UIButton!
    @IBOutlet var forgotPasswordLabel: UILabel!
    
    private var viewModel: LoginViewModel!
    // MARK: - Lifecycle
    static func create(with viewModel: LoginViewModel) -> LoginViewController {
        let view = LoginViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.viewDidLoad()
        bind()
    }
    
    private func bind() {
        viewModel.email.bind(to: emailTextField)
        viewModel.password.bind(to: passwordTextField)
        
        viewModel.loading.observe(on: self) { [weak self] isLoading in
            self?.view.loading(on: isLoading)
        }
        
        viewModel.isEmailAndPasswordValid.observe(on: self) { [weak self] isValid in
            self?.buttonContinue.isEnabled = isValid
            self?.buttonContinue.backgroundColor = isValid ? .backgroundDarkGray : .lightGray
        }
        
        viewModel.didShowMessage = { [weak self] message in
            self?.showAlert(title: message, message: .emptyString)
        }
    }
    
    private func setupView() {
        emailTextField.placeHolder = "Email"
        passwordTextField.placeHolder = "Password"
        
        forgotPasswordLabel.underline()
        
        buttonContinue.layer.cornerRadius = 14.0
        buttonContinue.isEnabled = false
        buttonContinue.backgroundColor = .lightGray
        
        signupLabel.underlineText(textToUnderline: "Sign Up")
        
        let tapGestureView = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureView)
        
        let tapGestureScrollView = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        scrollView.addGestureRecognizer(tapGestureScrollView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        view.endEditing(true)
        viewModel.didContinue()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

private extension LoginViewController {
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    func showAlert(
        title: String = "",
        message: String,
        preferredStyle: UIAlertController.Style = .alert,
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
}

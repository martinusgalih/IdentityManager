//
//  LoginViewModel.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 12/02/24.
//

import Foundation

struct LoginViewModelActions {
    let loginButtonTapped: (LoginPage) -> Void
}

protocol LoginViewModelInput {
    func viewDidLoad()
    func didContinue()
    func checkEmailFormat(_ text: String)
    func checkPasswordFormat(_ text: String)
}

protocol LoginViewModelOutput {
    var email: Observable<String?> { get }
    var password: Observable<String?> { get }
    var loading: Observable<Bool> { get }
    var error: Observable<String?> { get }
    var isEmailAndPasswordValid: Observable<Bool> { get }
    var didShowMessage: ((String) -> Void)? { get set }
}

typealias LoginViewModel = LoginViewModelInput & LoginViewModelOutput

final class DefaultLoginViewModel: LoginViewModel {
    
    private let fetchLoginUseCase: FetchLoginUseCase?
    private let actions: LoginViewModelActions?
    private let mainQueue: DispatchQueueType
    
    private var loginTask: Cancellable? { willSet { loginTask?.cancel() } }
    // MARK: - OUTPUT
    var loading: Observable<Bool> = .init(false)
    var error: Observable<String?> = .init(nil)
    var email: Observable<String?> = .init(nil)
    var password: Observable<String?> = .init(nil)
    var isEmailAndPasswordValid: Observable<Bool> = .init(false)
    var didShowMessage: ((String) -> Void)? = nil
    // MARK: - Init
    init(
        fetchLoginUseCase: FetchLoginUseCase,
        actions: LoginViewModelActions? = nil,
        mainQueue: DispatchQueueType = DispatchQueue.main
    ) {
        self.fetchLoginUseCase = fetchLoginUseCase
        self.actions = actions
        self.mainQueue = mainQueue
    }
    
    func viewDidLoad() {
        email.observe(on: self) { [weak self] email in
            guard let email else { return }
            self?.checkEmailFormat(email)
        }
        
        password.observe(on: self) { [weak self] password in
            guard let password else { return }
            self?.checkPasswordFormat(password)
        }
        
        error.observe(on: self) { [weak self] error in
            self?.isEmailAndPasswordValid.value = false
            guard let error else {
                if self?.password.value?.isEmpty ?? true == false,
                   self?.email.value?.isEmpty ?? true == false {
                    self?.isEmailAndPasswordValid.value = true
                }
                return
            }
            SnackbarView().showMessage(error)
        }
    }
    
    func didContinue() {
        login(username: email.value ?? .emptyString, password: password.value ?? .emptyString)
    }
    
    func checkEmailFormat(_ text: String) {
        error.value = nil
        if !text.isValidEmail() {
            error.value = "Email tidak valid"
        }
    }
    
    func checkPasswordFormat(_ text: String) {
        error.value = nil
        if !text.isValidPassword() {
            error.value = "Password harus terdiri 1 huruf besar, 1 huruf kecil, 1 angka, dan 1 karakter spesial"
        }
    }
    
}

extension DefaultLoginViewModel {
    private func login(username: String, password: String) {
        error.value = nil
        loading.value = true
        loginTask = fetchLoginUseCase?.fetch(username: username, password: password,completion: { [weak self] result in
            self?.loading.value = false
            switch result {
            case .success(let response):
                self?.didShowMessage?("Sukses Login")
                print("#Success Login \(response)")
            case .failure(let error):
                self?.didShowMessage?("Gagal Login")
                print("#Error Login \(error.localizedDescription)")
            }
        })
    }
}

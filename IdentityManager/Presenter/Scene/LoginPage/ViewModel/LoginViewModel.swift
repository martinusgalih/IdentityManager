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
    var loading: Observable<Bool> { get }
    var error: Observable<String?> { get }
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
        login()
    }
    
    func didContinue() {
    }
    
    func checkEmailFormat(_ text: String) {
    }
    
    func checkPasswordFormat(_ text: String) {
    }
}

extension DefaultLoginViewModel {
    private func login() {
        loading.value = true
        loginTask = fetchLoginUseCase?.fetch(completion: { response in
            print("Response \(response)")
        })
    }
}

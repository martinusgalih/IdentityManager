//
//  LoginSceneDIContainer.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 12/02/24.
//

import UIKit

final class LoginSceneDIContainer: LoginFlowCoordinatorDependencies {

    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    // MARK: - Login Page
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController {
        LoginViewController.create(with: makeLoginViewModel(actions: actions))
    }
    
    func makeLoginViewModel(actions: LoginViewModelActions) -> LoginViewModel {
        DefaultLoginViewModel(fetchLoginUseCase: makeLoginUseCase())
    }
    
    // MARK: - Use Cases
    func makeLoginUseCase() -> FetchLoginUseCase {
       DefaultFetchLoginUseCase(loginRepository: makeLoginRepository())
    }
    
    func makeLoginRepository() -> DefaultLoginRepository {
        DefaultLoginRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
    // MARK: - Flow Coordinators
    func makeLoginFlowCoordinator(navigationController: UINavigationController) -> LoginFlowCoordinator {
        LoginFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

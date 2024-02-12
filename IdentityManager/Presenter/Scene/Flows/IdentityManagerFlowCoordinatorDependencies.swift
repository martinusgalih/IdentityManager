//
//  IdentityManagerFlowCoordinatorDependencies.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 12/02/24.
//

import UIKit

protocol LoginFlowCoordinatorDependencies  {
    func makeLoginViewController(
        actions: LoginViewModelActions
    ) -> LoginViewController
}

final class LoginFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: LoginFlowCoordinatorDependencies

    private weak var loginVC: LoginViewController?
    
    init(navigationController: UINavigationController,
         dependencies: LoginFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = LoginViewModelActions(loginButtonTapped: loginButtonTapped)
        let vc = dependencies.makeLoginViewController(actions: actions)
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(vc, animated: false)
        loginVC = vc
    }

    private func loginButtonTapped(response: LoginPage) {
        print("tapped")
    }
}

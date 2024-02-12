//
//  AppFlowCoordinator.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 12/02/24.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        // TODO: - check if user needs to login, if yes we would run login flow
        let sceneDIContainer = appDIContainer.makeLoginSceneDIContainer()
        let flow = sceneDIContainer.makeLoginFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}

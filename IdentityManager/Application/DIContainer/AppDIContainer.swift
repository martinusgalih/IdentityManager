//
//  AppDIContainer.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 12/02/24.
//

import Foundation

final class AppDIContainer {
    
    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(
            baseURL: URL(string: APIEndpoints.baseUrl)!
        )
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    
    // MARK: - DIContainers of scenes
    func makeLoginSceneDIContainer() -> LoginSceneDIContainer {
        let dependencies = LoginSceneDIContainer.Dependencies(
            apiDataTransferService: apiDataTransferService
        )
        return LoginSceneDIContainer(dependencies: dependencies)
    }
}

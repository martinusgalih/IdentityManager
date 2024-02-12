//
//  DefaultLoginRepository.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 12/02/24.
//

import Foundation

final class DefaultLoginRepository {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultLoginRepository: LoginRepository {
    func fetchLogin(username: String,
                    password: String,
                    completion: @escaping (Result<LoginPage, Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        let endpoint = APIEndpoints.login(username: username, password: password)
        task.networkTask = dataTransferService.request(
            with: endpoint
        ) { result in
            switch result {
            case .success(let response):
                let page = response.data.toDomain()
                completion(.success(page))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
}

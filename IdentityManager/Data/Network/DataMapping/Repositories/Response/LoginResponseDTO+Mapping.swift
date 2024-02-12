//
//  LoginResponseDTO+Mapping.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 10/02/24.
//

// MARK: - Data Transfer Object

struct LoginResponseDTO: Decodable {
    let accessToken: String?
}

extension LoginResponseDTO {
    func toDomain() -> LoginPage {
        .init(accessToken: accessToken)
    }
}

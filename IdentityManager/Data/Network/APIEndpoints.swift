//
//  APIEndpoints.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 10/02/24.
//

import Foundation

struct SuccessResponse<T>: Decodable where T: Decodable {
    let responseCode: String?
    let data: T
    let responseMessage: String?
}

struct APIEndpoints {
    static var baseUrl: String {
        "https://run.mocky.io"
    }
    
    static func login(username: String, password: String) -> Endpoint<SuccessResponse<LoginResponseDTO>> {
        let requestQuery = LoginRequestQuery(username: username, password: password)
        return Endpoint(
            path: "v3/076e7b24-1a47-42c6-b0a9-5ad49234331f",
            method: .post,
            bodyParameters: ["username": requestQuery.username,
                             "password": requestQuery.password]
        )
    }
    
    static func getImage(
        path: String
    ) -> Endpoint<Data> {
        Endpoint(
            path: path,
            method: .get,
            responseDecoder: RawDataResponseDecoder()
        )
    }
}

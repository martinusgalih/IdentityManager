//
//  IdentityResponseDTO+Mapping.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 12/02/24.
//

import Foundation

struct IdentityResponseDTO: Decodable {
    let count: Int?
    let rows: [IdentityDTO]
}

extension IdentityResponseDTO {
    struct IdentityDTO: Decodable {
        let id: String?
        let nik: String?
        let name: String?
        let phone: String?
        let image: String?
        let phoneNo: String?
    }
}

// MARK: Mapping to Domain
extension IdentityResponseDTO {
    func toDomain() -> IdentityPage {
        return .init(count: count, 
                     rows: rows.map { $0.toDomain()} )
    }
}

extension IdentityResponseDTO.IdentityDTO {
    func toDomain() -> Identity {
        return .init(id: id,
                     nik: nik,
                     name: name,
                     phone: phone,
                     image: image,
                     phoneNo: phoneNo)
    }
}

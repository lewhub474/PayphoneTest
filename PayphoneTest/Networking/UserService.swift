//
//  UserService.swift
//  PayphoneTest
//
//  Created by Macky on 29/03/25.
//

import Foundation
import Alamofire

enum NetworkError: LocalizedError {
    case invalidURL
    case requestFailed(String)
    case decodingFailed
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "La URL proporcionada es inválida."
        case .requestFailed(let reason):
            return "La solicitud falló: \(reason)"
        case .decodingFailed:
            return "Error al decodificar los datos."
        case .unknown:
            return "Ocurrió un error desconocido."
        }
    }
}

class UserService {
    func fetchUsers() async throws -> [User] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            throw NetworkError.invalidURL
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url).validate().responseDecodable(of: [User].self) { response in
                switch response.result {
                case .success(let users):
                    continuation.resume(returning: users)
                case .failure(let afError):
                    let networkError: NetworkError
                    if let underlyingError = afError.underlyingError {
                        networkError = .requestFailed(underlyingError.localizedDescription)
                    } else if let errorDescription = afError.errorDescription {
                        networkError = .requestFailed(errorDescription)
                    } else {
                        networkError = .unknown
                    }
                    continuation.resume(throwing: networkError)
                }
            }
        }
    }
}

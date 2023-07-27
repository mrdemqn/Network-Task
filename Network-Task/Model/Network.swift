//
//  Network.swift
//  Network-Training
//
//  Created by Димон on 25.07.23.
//

import Foundation

protocol NetworkProtocol {
    func get<T: Codable>(_ type: T.Type,
                         link: String,
                         _ completion: @escaping (Result<T>) -> Void)
}

final class Network: NetworkProtocol {
    
    func get<T: Codable>(_: T.Type,
                         link: String,
                         _ completion: @escaping (Result<T>) -> Void) {
        guard let url = URL(string: link) else { return completion(.failure(.linkError)) }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { return completion(.failure(.receivedError)) }
            
            guard let data = data else { return completion(.failure(.dataError)) }
            
            do {
                let value = try JSONDecoder().decode(T.self, from: data)
                completion(.success(value))
            } catch {
                completion(.failure(.jsonDecodeError))
            }
            
        }.resume()
    }
}

enum Result<T> {
    case success(T)
    
    case failure(CustomErrors)
}

enum CustomErrors: String, Error {
    case receivedError = "Received Error"
    case linkError = "Link Error"
    case dataError = "Data Error"
    case jsonDecodeError = "Json Decode Error"
}

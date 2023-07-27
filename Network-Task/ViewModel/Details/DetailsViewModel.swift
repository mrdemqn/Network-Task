//
//  DetailsViewModel.swift
//  Network-Task
//
//  Created by Димон on 25.07.23.
//

import Foundation

protocol DetailsViewModelProtocol {
    var user: User? { get set }
    
    var updateClosure: ((User?) -> Void)? { get set }
    
    func fetchUsers(userId: Int)
}

final class DetailsViewModel: DetailsViewModelProtocol {
    
    private let network: NetworkProtocol = Network()
    
    var user: User? {
        didSet {
            updateClosure?(user)
        }
    }
    
    var updateClosure: ((User?) -> Void)?
    
    func fetchUsers(userId: Int) {
        let link = "https://jsonplaceholder.typicode.com/users/\(userId)"
        network.get(User.self, link: link) { result in
            switch result {
                case .success(let user):
                    self.user = user
                case .failure(let error):
                    print("Custom Error -> \(error)")
            }
        }
    }
}

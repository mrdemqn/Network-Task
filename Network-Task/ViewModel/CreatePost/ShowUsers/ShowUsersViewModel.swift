//
//  ShowUsersViewModel.swift
//  Network-Task
//
//  Created by Димон on 27.07.23.
//

import Foundation

protocol ShowUsersViewModelProtocol {
    
    var users: [User] { get set }
    
    var updateClosure: (() -> Void)? { get set }
    
    func fetchUsers()
    
    func makeCellModel(_ user: User) -> PostTableViewModel
}

final class ShowUsersViewModel: ShowUsersViewModelProtocol {
    
    private let network: NetworkProtocol = Network()
    
    var users: [User] = [] {
        didSet {
            updateClosure?()
        }
    }
    
    var updateClosure: (() -> Void)?
    
    func fetchUsers() {
        network.get([User].self, link: NetworkConstants.userLink) { result in
            switch result {
                case .success(let users):
                    self.users = users
                case .failure(let error):
                    print("Failure Fetching Posts: \(error)")
            }
        }
    }
    
    func makeCellModel(_ user: User) -> PostTableViewModel {
        return PostTableViewModel(title: user.name,
                                  body: user.email)
    }
}

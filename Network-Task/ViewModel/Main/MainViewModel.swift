//
//  MainViewModel.swift
//  Network-Training
//
//  Created by Димон on 25.07.23.
//

import Foundation

protocol MainViewModelProtocol {
    var posts: [Post] { get set }
    
    var updateClosure: (() -> Void)? { get set }
    
    var addPostClosure: ((Post) -> Void)? { get set }
    
    func fetchPosts()
    
    func addPost(_ post: Post)
}

final class MainViewModel: MainViewModelProtocol {
    
    private let network: NetworkProtocol = Network()
    
    var posts: [Post] = [] {
        didSet {
            updateClosure?()
        }
    }
    
    var updateClosure: (() -> Void)?
    
    var addPostClosure: ((Post) -> Void)?
    
    func fetchPosts() {
        network.get([Post].self, link: NetworkConstants.postsLink) { result in
            switch result {
                case .success(let posts):
                    self.posts = posts
                case .failure(let error):
                    print("Custom Error -> \(error)")
            }
        }
    }
    
    func addPost(_ post: Post) {
        posts.append(post)
    }
}

//
//  AddPostViewModel.swift
//  Network-Task
//
//  Created by Димон on 27.07.23.
//

import Foundation

protocol AddPostViewModelProtocol {
    
    func mapPost(user: User,
                 title: String,
                 body: String) -> Post
}

final class AddPostViewModel: AddPostViewModelProtocol {
    
    func mapPost(user: User,
                 title: String,
                 body: String) -> Post {
        return Post(userId: user.id,
                    id: UUID().hashValue,
                    title: title,
                    body: body)
    }
}

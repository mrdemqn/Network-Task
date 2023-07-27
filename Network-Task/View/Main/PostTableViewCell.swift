//
//  PostTableViewCell.swift
//  Network-Training
//
//  Created by Димон on 18.07.23.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    
    func configure(_ model: PostTableViewModel) {
        titleLabel.text = model.title
        bodyLabel.text = model.body
    }
}

struct PostTableViewModel {
    let title: String
    let body: String
}

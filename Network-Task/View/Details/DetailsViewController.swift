//
//  DetailsViewController.swift
//  Network-Task
//
//  Created by Димон on 25.07.23.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var companyNameLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: DetailsViewModelProtocol!
    
    var userId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.sizeToFit()
        viewModel = DetailsViewModel()
        bind()
        
        viewModel.fetchUsers(userId: userId!)
    }
}

extension DetailsViewController {
    
    private func bind() {
        viewModel.updateClosure = { [weak self] user in
            DispatchQueue.main.async {
                self?.headerLabel.text = user?.address.city
                self?.nameLabel.text = user?.name
                self?.emailLabel.text = user?.email
                self?.companyNameLabel.text = user?.company.name
                self?.titleLabel.text = user?.phone
                self?.activityIndicator.stopAnimating()
                self?.showLabels()
            }
        }
    }
    
    private func showLabels() {
        headerLabel.isHidden.toggle()
        nameLabel.isHidden.toggle()
        emailLabel.isHidden.toggle()
        companyNameLabel.isHidden.toggle()
        titleLabel.isHidden.toggle()
    }
}

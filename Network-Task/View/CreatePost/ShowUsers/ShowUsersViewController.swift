//
//  ShowUsersViewController.swift
//  Network-Task
//
//  Created by Димон on 27.07.23.
//

import UIKit

final class ShowUsersViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: ShowUsersViewModelProtocol!
    
    var addPostClosure: ((Post) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ShowUsersViewModel()
        
        setupTableView()
        setupXibs()
        
        setupNavigationBar()
        
        setupUpdateClosure()
        
        viewModel.fetchUsers()
    }
}

extension ShowUsersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Post", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        let user = viewModel.users[indexPath.item]
        let model = viewModel.makeCellModel(user)
        cell.configure(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.users[indexPath.item]
        let storyboard = UIStoryboard(name: "AddPostStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "AddPostStoryboard") as? AddPostViewController else { return }
        viewController.user = user
        viewController.addPostClosure = addPostClosure
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ShowUsersViewController {
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupXibs() {
        let nib = UINib(nibName: "\(PostTableViewCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Post")
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
    }
    
    @objc private func cancelAction() {
        dismiss(animated: true)
    }
    
    private func setupUpdateClosure() {
        viewModel.updateClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

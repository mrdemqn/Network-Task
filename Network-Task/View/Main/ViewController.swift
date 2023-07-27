//
//  ViewController.swift
//  Network-Training
//
//  Created by Димон on 18.07.23.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel: MainViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        setTableView()
        setXibs()
        setupNavigationBar()
        setupAddPostClosure()
        
        bindViewModel()
        
        viewModel.fetchPosts()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Post", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        let post = viewModel.posts[indexPath.item]
        let model = makeCellModel(post)
        cell.configure(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = viewModel.posts[indexPath.item]
        
        let storyboard = UIStoryboard(name: "DetailsStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "DetailsStoryboard") as? DetailsViewController else { return }
        viewController.userId = post.userId
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController {
    
    private func makeCellModel(_ post: Post) -> PostTableViewModel {
        return PostTableViewModel(title: post.title,
                                  body: post.body)
    }
    
    private func setXibs() {
        let nib = UINib(nibName: "\(PostTableViewCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Post")
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPostAction))
    }
    
    private func bindViewModel() {
        viewModel.updateClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupAddPostClosure() {
        viewModel.addPostClosure = { [weak self] post in
            self?.viewModel.addPost(post)
        }
    }
    
    @objc private func addPostAction() {
        let storyboard = UIStoryboard(name: "ShowUsersStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ShowUsersStoryboard") as? ShowUsersViewController else { return }
        viewController.addPostClosure = viewModel.addPostClosure
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
    }
}

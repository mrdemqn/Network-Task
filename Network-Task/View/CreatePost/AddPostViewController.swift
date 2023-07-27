//
//  AddPostViewController.swift
//  Network-Task
//
//  Created by Димон on 27.07.23.
//

import UIKit

final class AddPostViewController: UIViewController {
    
    @IBOutlet private weak var titleTextField: UITextField!
    
    @IBOutlet private weak var bodyTextView: UITextView!
    
    private var viewModel: AddPostViewModelProtocol!
    
    var user: User?
    
    var addPostClosure: ((Post) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddPostViewModel()
        
        setupNavigationBar()
    }
}

extension AddPostViewController {
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(cancelAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(saveAction))
    }
    
    @objc private func cancelAction() {
        dismiss(animated: true)
    }
    
    @objc private func saveAction() {
        guard let user = user,
              let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty else { return }
        
        let post = viewModel.mapPost(user: user,
                                     title: title,
                                     body: body)
        addPostClosure?(post)
        dismiss(animated: true)
    }
}

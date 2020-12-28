//
//  AppleReposViewController.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 27/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import UIKit

class AppleReposViewController: UIViewController {
    
    private var baTableView: BATableView?
    
    private let viewModel: AppleReposViewModel?
    
    init(title: String, viewModel: AppleReposViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        baTableView = BATableView()
        self.view = baTableView
        bindElements()
    }

    private func bindElements() {
        guard let viewModel = viewModel else { return }
        baTableView?.tableView.delegate = self
        baTableView?.tableView.dataSource = self
        
        viewModel.fetchRepos()
        viewModel.repos.bind(skip: true) { [weak self] repos in
            if !repos.isEmpty {
                self?.baTableView?.tableView.reloadData()
            }
        }
    }
}

extension AppleReposViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.repos.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let repos = viewModel?.repos.value else { return cell }
        cell.textLabel?.text = repos[indexPath.row].name ?? ""
        return cell
    }
}

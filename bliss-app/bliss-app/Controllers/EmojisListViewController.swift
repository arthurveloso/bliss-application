//
//  EmojisListViewController.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 26/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import UIKit

class EmojisListViewController: UIViewController {
    
    private var emojisView: EmojisListView?
    
    private let viewModel: EmojisListViewModel?
    
    init(title: String, viewModel: EmojisListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        emojisView = EmojisListView()
        self.view = emojisView
        bindElements()
    }
    
    private func bindElements() {

    }
}

//
//  HomeViewController.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 23/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var homeView: HomeView?
    
    private let viewModel: HomeViewModel?
    
    init(title: String, viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        homeView = HomeView(delegate: self)
        self.view = homeView
        bindElements()
    }
    
    private func bindElements() {
        viewModel?.randomEmoji.bind(skip: true, { [weak self] link in
            guard let self = self, let link = link else { return }
            self.homeView?.emojiImage.downloaded(from: link)
        })
    }
}

extension HomeViewController: HomeViewDelegate {
    func randomEmojiPressed() {
        viewModel?.getRandomEmoji()
    }
    
    func emojisListPressed() {
        viewModel?.goToEmojisList()
    }
    
    func searchPressed() {
        
    }
    
    func avatarsListPressed() {
        
    }
    
    func appleReposPressed() {
        
    }
}

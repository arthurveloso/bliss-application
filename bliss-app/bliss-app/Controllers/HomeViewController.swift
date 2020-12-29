//
//  HomeViewController.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 23/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import UIKit
import MBProgressHUD

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
        view.backgroundColor = .blissDark
    }
    
    private func bindElements() {
        viewModel?.randomEmoji.bind(skip: true, { [weak self] link in
            guard let self = self, let link = link else { return }
            self.homeView?.emojiImage.downloaded(from: link, completion: { _ in })
        })
        
        viewModel?.randomCachedEmoji.bind(skip: true, { [weak self] data in
            guard let self = self, let data = data else { return }
            self.homeView?.emojiImage.image = UIImage(data: data)
        })
        viewModel?.getRandomEmoji()
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
        guard let text = homeView?.searchBar.text, !text.isEmpty else { return }
//        self.showHud("Loading")
        viewModel?.searchUserAvatar(name: text)
    }
    
    func avatarsListPressed() {
        viewModel?.goToAvatarsList()
    }
    
    func appleReposPressed() {
        viewModel?.goToAppleRepos()
    }
}

extension UIViewController {
    func showHud(_ message: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.isUserInteractionEnabled = false
    }

    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}

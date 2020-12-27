//
//  HomeView.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 24/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import UIKit
import SnapKit

protocol HomeViewDelegate: class {
    func randomEmojiPressed()
    func emojisListPressed()
    func searchPressed()
    func avatarsListPressed()
    func appleReposPressed()
}

class HomeView: UIView {
    
    lazy var emojiImage: UIImageView = {
        let emoji = UIImageView()
        return emoji
    }()
    
    lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    lazy var randomEmojiButton: BlissButton = {
        let button = BlissButton(title: "Random Emoji")
        button.tag = 0
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var emojisListButton: BlissButton = {
        let button = BlissButton(title: "Emojis List")
        button.tag = 1
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var searchStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.textContentType = .username
        bar.autocapitalizationType = .none
        bar.barTintColor = .purple
        return bar
    }()
    
    lazy var searchButton: BlissButton = {
        let button = BlissButton(title: "Search")
        button.tag = 2
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var avatarsListButton: BlissButton = {
        let button = BlissButton(title: "Avatars List")
        button.tag = 3
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var appleReposButton: BlissButton = {
        let button = BlissButton(title: "Apple Repos")
        button.tag = 4
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    private weak var delegate: HomeViewDelegate?
    
    convenience init(delegate: HomeViewDelegate? = nil) {
        self.init(frame: .zero)
        self.delegate = delegate
        backgroundColor = .white
        setupSubviews()
    }
    
    func setupSubviews() {
        searchStack.addArrangedSubview(searchBar)
        searchStack.addArrangedSubview(searchButton)

        buttonsStack.addArrangedSubview(randomEmojiButton)
        buttonsStack.addArrangedSubview(emojisListButton)
        buttonsStack.addArrangedSubview(searchStack)
        buttonsStack.addArrangedSubview(avatarsListButton)
        buttonsStack.addArrangedSubview(appleReposButton)

        addSubview(emojiImage)
        emojiImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(150)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
        }

        addSubview(buttonsStack)
        buttonsStack.snp.makeConstraints { (make) in
            make.top.equalTo(emojiImage.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        searchButton.snp.makeConstraints { (make) in
            make.width.equalTo(buttonsStack.snp.width).multipliedBy(0.3)
        }
    }
    
    @objc
    func buttonPressed(sender: UIButton) {
        switch sender.tag {
        case 0:
            delegate?.randomEmojiPressed()
        case 1:
            delegate?.emojisListPressed()
        case 2:
            delegate?.searchPressed()
        case 3:
            delegate?.avatarsListPressed()
        case 4:
            delegate?.appleReposPressed()
        default:
            break
        }
    }
}

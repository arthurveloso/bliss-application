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
}

class HomeView: UIView {
    
    lazy var emojiImage: UIImageView = {
        let emoji = UIImageView()
        emoji.backgroundColor = .black
        return emoji
    }()
    
    lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private weak var delegate: HomeViewDelegate?
    
    convenience init(delegate: HomeViewDelegate? = nil) {
        self.init(frame: .zero)
        self.delegate = delegate
        setupSubviews()
    }
    
    func setupSubviews() {
        backgroundColor = .white
        
        addSubview(emojiImage)
        emojiImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(150)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
        }
    }
}

//
//  EmojisCell.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 26/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import UIKit

class EmojisCell: UICollectionViewCell {
    
    static let reuseId = "EmojisCell"

    lazy var emojiImage: UIImageView = {
        let image = UIImageView()
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setCorners()
        setSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCorners() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = .clear
    }
    
    func setSubviews() {
        self.contentView.addSubview(emojiImage)
        emojiImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(2)
        }
    }
}

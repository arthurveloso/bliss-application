//
//  BlissButton.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 24/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import UIKit

class BlissButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title.uppercased(), for: .normal)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStyle() {
        self.backgroundColor = .blissRed
        self.layer.cornerRadius = 5
    }
}

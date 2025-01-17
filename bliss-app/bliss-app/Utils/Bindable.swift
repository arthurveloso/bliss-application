//
//  Bindable.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 26/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import Foundation

class Bindable<T> {
    typealias BindType = ((T) -> Void)

    private var binds: [BindType] = []

    var value: T {
        didSet {
            execBinds()
        }
    }

    init(_ val: T) {
        value = val
    }

    func bind(skip: Bool = false, _ bind: @escaping BindType) {
        binds.append(bind)
        if skip {
            return
        }
        bind(value)
    }

    private func execBinds() {
        binds.forEach { [unowned self] bind in
            bind(self.value)
        }
    }
}

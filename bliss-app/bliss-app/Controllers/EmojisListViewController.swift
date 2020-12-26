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
        emojisView?.emojisCollection.register(EmojisCell.self, forCellWithReuseIdentifier: EmojisCell.reuseId)
        emojisView?.emojisCollection.delegate = self
        emojisView?.emojisCollection.dataSource = self
    }
}

extension EmojisListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.emojis.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojisCell.reuseId, for: indexPath) as? EmojisCell ?? EmojisCell()
        cell.emojiImage.downloaded(from: viewModel?.emojis[indexPath.item] ?? "")
        cell.backgroundColor = .red
        return cell
    }
}

extension EmojisListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.emojisView?.frame.width ?? 0.0) / 3.5
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

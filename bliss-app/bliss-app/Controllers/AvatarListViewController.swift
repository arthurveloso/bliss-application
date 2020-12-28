//
//  AvatarListViewController.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 27/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import UIKit

class AvatarListViewController: UIViewController {
    
    var baCollectionView: BACollectionView?
    
    let viewModel: AvatarListViewModel?
    
    init(title: String, viewModel: AvatarListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        baCollectionView = BACollectionView()
        self.view = baCollectionView
        bindElements()
    }
    
    private func bindElements() {
        guard let viewModel = viewModel else { return }
        baCollectionView?.collectionView.register(EmojisCell.self, forCellWithReuseIdentifier: EmojisCell.reuseId)
        baCollectionView?.collectionView.delegate = self
        baCollectionView?.collectionView.dataSource = self
        viewModel.avatars.bind(skip: true) { [weak self] avatars in
            if !avatars.isEmpty {
                self?.baCollectionView?.collectionView.reloadData()
            }
        }
        viewModel.fetchAvatars()
    }
}

extension AvatarListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.avatars.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojisCell.reuseId, for: indexPath) as? EmojisCell ?? EmojisCell()
        
        guard let avatars = viewModel?.avatars.value else { return cell }
        
        cell.emojiImage.image = UIImage(data: avatars[indexPath.item].avatar ?? Data())
        
        return cell
    }
    
    
}

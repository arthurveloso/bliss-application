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
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        baCollectionView = BACollectionView()
        self.view = baCollectionView
        bindElements()
        self.view.backgroundColor = .blissDark
    }
    
    private func bindElements() {
        guard let viewModel = viewModel else { return }
        baCollectionView?.collectionView.register(ItemsCell.self, forCellWithReuseIdentifier: ItemsCell.reuseId)
        baCollectionView?.collectionView.delegate = self
        baCollectionView?.collectionView.dataSource = self
        viewModel.avatars.bind(skip: true) { [weak self] avatars in
            self?.baCollectionView?.collectionView.reloadData()
        }
        viewModel.fetchAvatars()
    }
}

extension AvatarListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.avatars.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let avatar = viewModel?.avatars.value[indexPath.item] else { return }
        
        viewModel?.deleteAvatar(avatar: avatar)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemsCell.reuseId, for: indexPath) as? ItemsCell ?? ItemsCell()
        
        guard let avatars = viewModel?.avatars.value else { return cell }
        
        cell.emojiImage.image = UIImage(data: avatars[indexPath.item].avatar ?? Data())

        return cell
    }
}

extension AvatarListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.baCollectionView?.frame.width ?? 0.0) / 3.5
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
}

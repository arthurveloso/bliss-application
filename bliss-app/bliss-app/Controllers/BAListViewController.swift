//
//  BAListViewController.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 26/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import UIKit

class BAListViewController: UIViewController {
    
    private var baCollectionView: BACollectionView?
    
    private let viewModel: EmojisListViewModel?
    
    var refresher = UIRefreshControl()
    
    init(title: String, viewModel: EmojisListViewModel) {
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
        
        addRefresher()
        
        if viewModel.shouldFetchEmojis {
            viewModel.fetchEmojis()
            viewModel.fetchedResult.bind(skip: true, { [weak self] isFetched in
                guard let self = self, isFetched == true else { return }
                self.baCollectionView?.collectionView.reloadData()
            })
        }
    }
    
    private func addRefresher() {
        baCollectionView?.collectionView.refreshControl = refresher
        baCollectionView?.collectionView.alwaysBounceVertical = true
        refresher.tintColor = .blissRed
        refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc
    private func refreshData() {
        baCollectionView?.collectionView.refreshControl?.beginRefreshing()
        viewModel?.refreshData()
        DispatchQueue.main.async { [weak self] in
            self?.baCollectionView?.collectionView.refreshControl?.endRefreshing()
            self?.baCollectionView?.collectionView.reloadData()
        }
    }
}

extension BAListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.shouldFetchEmojis ? viewModel.emojis.count : viewModel.emojisImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemsCell.reuseId, for: indexPath) as? ItemsCell ?? ItemsCell()
        
        guard let viewModel = viewModel else { return cell }
        
        if viewModel.shouldFetchEmojis {
            let emoji = viewModel.emojis[indexPath.item]
            
            cell.emojiImage.downloaded(from: emoji) { [weak self] data in
                self?.viewModel?.saveImage(imageData: data)
            }
        } else {
            let imgData = viewModel.emojisImage[indexPath.item].image ?? Data()
            cell.emojiImage.image = UIImage(data: imgData)
        }
        
        cell.backgroundColor = .blissRed
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        collectionView.performBatchUpdates({
            if viewModel.shouldFetchEmojis {
                viewModel.emojis.remove(at: indexPath.item)
            } else {
                viewModel.emojisImage.remove(at: indexPath.item)
            }
            collectionView.deleteItems(at: [indexPath])
        }, completion: nil)
        
    }
}

extension BAListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.baCollectionView?.frame.width ?? 0.0) / 3.5
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

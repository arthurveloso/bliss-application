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
        emojisView = EmojisListView()
        self.view = emojisView
        bindElements()
    }
    
    private func bindElements() {
        guard let viewModel = viewModel else { return }
        emojisView?.emojisCollection.register(EmojisCell.self, forCellWithReuseIdentifier: EmojisCell.reuseId)
        emojisView?.emojisCollection.delegate = self
        emojisView?.emojisCollection.dataSource = self
        
        addRefresher()
        
        if viewModel.shouldFetchEmojis {
            viewModel.fetchEmojis()
            viewModel.fetchedResult.bind(skip: true, { [weak self] isFetched in
                guard let self = self, isFetched == true else { return }
                self.emojisView?.emojisCollection.reloadData()
            })
        }
    }
    
    private func addRefresher() {
        emojisView?.emojisCollection.refreshControl = refresher
        emojisView?.emojisCollection.alwaysBounceVertical = true
        refresher.tintColor = .red
        refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc
    private func refreshData() {
        emojisView?.emojisCollection.refreshControl?.beginRefreshing()
        viewModel?.refreshData()
        DispatchQueue.main.async { [weak self] in
            self?.emojisView?.emojisCollection.refreshControl?.endRefreshing()
            self?.emojisView?.emojisCollection.reloadData()
        }
    }
}

extension EmojisListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.shouldFetchEmojis ? viewModel.emojis.count : viewModel.emojisImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojisCell.reuseId, for: indexPath) as? EmojisCell ?? EmojisCell()
        
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
        
        cell.backgroundColor = .red
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

extension EmojisListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.emojisView?.frame.width ?? 0.0) / 3.5
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

//
//  ViewController.swift
//  OMDBClientApplication
//
//  Created by Mac mini on 10/8/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    var searchCoordinator: SearchCoordinator!
    var fetchingInProgress = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.dataSource = nil
        collectionView.delegate = nil
        fetchData()
    }

    private func fetchData() {
        
        guard IJReachability.isConnectedToNetwork() else {
            showAlert(message: "Please check your internet connection")
            return
        }
        BatmanManager.shared.getdata { [weak self] coordinator, error in
            guard let `self` = self else { return }
            if let coordinator = coordinator {
                self.searchCoordinator = coordinator
                DispatchQueue.main.async {
                    self.intialSetUp()
                    self.collectionView.dataSource = self
                    self.collectionView.delegate = self
                    self.collectionView.reloadData()
                }
              
            }
        }
    }
    
    private func intialSetUp() {
        collectionView.registerCell(String(describing: CollectionViewCell.self))
        collectionView.registerCell(String(describing: LoadingCollectionViewCell.self))
        collectionView.dataSource = self
        let cellSize = CGSize(width: view.frame.width/2 - 20 , height: 181)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.height >= scrollView.contentSize.height {
            print("ScrollView reach bottom")
            if let searchCoordinator = searchCoordinator, searchCoordinator.totalResultsValue > searchCoordinator.search.count,
                !fetchingInProgress {
                fetchingInProgress = true
                fetchMoreData()
            } else {
                print("Already fetch all products")
            }
        }
    }
    
    
    private func fetchMoreData() {
        guard IJReachability.isConnectedToNetwork() else {
            showAlert(message: "Please check your internet connection")
            return
        }
        BatmanManager.shared.getdata { [weak self] coordinator, error in
            guard let `self` = self else { return }
            if let coordinator = coordinator {
                self.searchCoordinator = coordinator
                 DispatchQueue.main.async {
                  self.collectionView.reloadData()
                  //self.collectionView.scrollToBottom(animated: true)
                  self.fetchingInProgress = false
                }
            }
        }
    }
    
}

// MARK: - CollectionViewDataSource and Delegate
extension CollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of rows \(searchCoordinator.search.count)")
        return searchCoordinator.search.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item < searchCoordinator.search.count {
            let cell: CollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
            if let search = searchCoordinator.search[safe: indexPath.row] {
                cell.setUpView(search: search)
            }
            return cell
        } else {
            let cell: LoadingCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
            fetchMoreData()
            return cell
        }
        
    }
    
}


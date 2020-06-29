//
//  MainViewController.swift
//  GiniApps
//
//  Created by niv ben-porath on 29/06/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    private lazy var collectionView = makeCollectionView()
    
    let shownNumbersViewModel : ShownNumbersViewModel
    
    //MARK: - init
    init(shownNumbersViewModel : ShownNumbersViewModel) {
        self.shownNumbersViewModel = shownNumbersViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
        requestArrayData()
    }
    

    //MARK: - request data
    private func requestArrayData() {
        shownNumbersViewModel.requestArray { [weak self](error) in
            guard let self = self else {return}
            if let requestError = error {
                print(requestError.localizedDescription)
            }else{
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: - layout
    private func layoutView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10)
        ])
    }
    
    //MARK: - factory
    private func makeCollectionView() -> UICollectionView {
        let collectionView =  UICollectionView(frame: view.bounds, collectionViewLayout:UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(LowOrangeCollectionViewCell.self, forCellWithReuseIdentifier: LowOrangeCollectionViewCell.reuseId)
        collectionView.register(HighRedCollectionViewCell.self, forCellWithReuseIdentifier: HighRedCollectionViewCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
}

extension MainViewController : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width/4
        let height = shownNumbersViewModel.height(at: indexPath.row)
        return CGSize(width: width, height: height)
    }
}

extension MainViewController : UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shownNumbersViewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let height = shownNumbersViewModel.height(at: indexPath.row)
        if height == 100 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HighRedCollectionViewCell.reuseId, for: indexPath) as? HighRedCollectionViewCell else {
                preconditionFailure("incorrect cell")
            }
            cell.setupCell(with: shownNumbersViewModel.number(at: indexPath.row))
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LowOrangeCollectionViewCell.reuseId, for: indexPath) as? LowOrangeCollectionViewCell else {
                preconditionFailure("incorrect cell")
                
            }
            cell.setupCell(with: shownNumbersViewModel.number(at: indexPath.row))
            return cell
        }
        
    }
    
    
}



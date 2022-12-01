//
//  HourlyTableViewCell.swift
//  weatherApp
//
//  Created by Андрей Антонов on 23.11.2022.
//  Copyright © 2022 Андрей Антонов. All rights reserved.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {
    
    private var collectionView: UICollectionView?
    private var hourlyModel = [HourlyData]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height),
            collectionViewLayout: layout
        )
        collectionView?.register(
            HourlyCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: HourlyCollectionViewCell.self)
        )
        collectionView?.dataSource = self
        
        contentView.addSubview(collectionView ?? UICollectionView())
    }
    
    func configure(model: [HourlyData]) {
        self.hourlyModel = model
        collectionView?.reloadData()
    }
    
}

// MARK: UICollectionViewDataSource

extension HourlyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: HourlyCollectionViewCell.self),
            for: indexPath
            ) as! HourlyCollectionViewCell
        
        cell.configure(hourlyModel[indexPath.row])

        return cell
    }
}

extension HourlyTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 90)
    }
}

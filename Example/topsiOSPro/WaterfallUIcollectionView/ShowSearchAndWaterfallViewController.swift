//
//  ShowSearchAndWaterfallViewController.swift
//  topsiOSPro_Example
//
//  Created by 李桂盛 on 2020/4/2.
//  Copyright © 2020 李效晋. All rights reserved.
//

import UIKit
import topsiOSPro

class ShowSearchAndWaterfallViewController: BaseSearchAndWaterfulController {

    let data: [[UIColor]] = [
        [ .black,
          .blue,
          .brown,
          .cyan,
          .green,
          .magenta,
          .darkGray,
          .orange
        ],
        [.blue, .brown]
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        setupConfig()
    }
    func setupConfig() {
        self.topSpace = 10.0
        self.headerHeight = 50.0
        self.footerHeight = 55.0
        self.delegate = self
        super.setupSearchAndWaterfulController()
    }

}

extension ShowSearchAndWaterfallViewController: BaseSearchAndWaterfulControllerDelegate {
    func waterfallLayoutWith(index: IndexPath) -> CGFloat {
        if index.row % 2 == 0 {
            return 1.5
        }
        return 1.0
    }
    
    func numberOfCols() -> Int {
        return 2
    }
    
    func numberOfSections() -> Int {
        return data.count
    }
    func numberOfItems(section: Int) -> Int {
        return data[section].count
    }
    
    func cellForItem(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: waterfallCell, for: indexPath)
        cell.contentView.backgroundColor = data[indexPath.section][indexPath.row]
        return cell
    }
    
    func viewforSuppElementHeader(indexpath: IndexPath) -> UICollectionReusableView {
        let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: waterfallHeader, for: indexpath)
        header.backgroundColor = .red
        return header
    }
    
    func viewforSuppElementFotter(indexpath: IndexPath) -> UICollectionReusableView {
        let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: waterfallFooter, for: indexpath)
        header.backgroundColor = .green
        return header
    }
    
    func didSelected(indexpath: IndexPath) {
        print("\(indexpath.row)")
    }
    func searchTextWith(text: String) {
        print(text)
        self.show(text: "搜索的关键字:---->  \(text)")
    }
    
}

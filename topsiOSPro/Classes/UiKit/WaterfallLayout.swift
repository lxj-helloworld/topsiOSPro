//
//  WaterfallLayout.swift
//  瀑布流
//
//  Created by 李桂盛 on 2020/4/1.
//  Copyright © 2020 LeeSin. All rights reserved.
//

import Foundation
import UIKit

// 瀑布流代理
@objc protocol WaterfallLayoutDataSource : class {
    
    /// 指定ITEM的高度
    ///
    /// - Parameters:
    ///   - layout: 布局
    ///   - indexPath: 位置
    /// - Returns: 高度比例
    func waterfallLayout(_ layout : WaterfallLayout, indexPath : IndexPath) -> CGFloat
    
    /// 瀑布流一共有多少列，默认时2列
    /// - Parameter layout: 布局
    /// - Returns: 列数
    @objc optional func numberOfColsInWaterfallLayout(_ layout : WaterfallLayout) -> Int
}

class WaterfallLayout: UICollectionViewFlowLayout {
    
    // MARK: 对外提供属性
    // 瀑布流数据源代理
    weak var dataSource : WaterfallLayoutDataSource?
    
    // MARK: 私有属性
    // 布局属性数组
    private lazy var attrsArray : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    // 最高的高度
    private var maxH : CGFloat = 0
    
    //索引
    private var startIndex = 0
    
    //头部
    var layoutHeader: UICollectionViewLayoutAttributes!
    //尾部
    var layoutFooter: UICollectionViewLayoutAttributes!
    //cell内容的偏移量顶部距离父视图高度 默认为0 假如上面有banner或者其他视图,可自行定义
    var topSpace: CGFloat = 0
    //header height 头视图高度
    var headerHeight: CGFloat = 0
    //footer height 尾视图高度
    var footerHeight: CGFloat = 0
    
    init(topSpace: CGFloat, headerHeight: CGFloat, footerHeight: CGFloat) {
        super.init()
        self.topSpace = topSpace
        self.headerHeight = headerHeight
        self.footerHeight = footerHeight
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WaterfallLayout {
    
    override func prepare() {
        super.prepare()
        
        let sectionCount = collectionView!.numberOfSections
        //获取item的个数
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        
        //获取列数
        let cols = dataSource?.numberOfColsInWaterfallLayout?(self) ?? 2
        //每一列的高度累计
        var colHeights = Array(repeating: self.sectionInset.top  + topSpace + headerHeight, count: cols)
        
        //计算Item的宽度（屏幕宽度铺满）
        let itemW = (collectionView!.bounds.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing * CGFloat(cols - 1)) / CGFloat(cols)
        attrsArray = Array.init()
        //计算所有的item的属性
        for i in 0..<itemCount {
            // 设置每一个Item位置相关的属性
            let indexPath = IndexPath(item: i, section: 0)
            
            // 根据位置创建Attributes属性
            let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 获取CELL的高度
            guard var height = dataSource?.waterfallLayout(self, indexPath: indexPath) else {
                fatalError("请设置数据源,并且实现对应的数据源方法")
            }
            height = height * itemW
            //取出当前列所属的列索引
            let index = i % cols
            
            //获取当前列的总高度
            var colH = colHeights[index]
            
            //将当前列的高度在加载当前ITEM的高度
            colH = colH + height + minimumLineSpacing
            
            //重新设置当前列的高度
            colHeights[i % cols] = colH
            
            // 5.设置item的属性
            attrs.frame = CGRect(x: self.sectionInset.left + (self.minimumInteritemSpacing + itemW) * CGFloat(index), y: colH - height - self.minimumLineSpacing, width: itemW, height: height)
            
            attrsArray.append(attrs)
        }
        
        // 4.记录最大值
        maxH = colHeights.max()!
        
        // 5.给startIndex重新复制
        startIndex = itemCount
        
        
        //头部
        layoutHeader = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: IndexPath(item: 0, section: 0))
        layoutHeader.frame = CGRect(x: 0, y: 0, width: ConstantsHelp.SCREENWITH, height: headerHeight)
        attrsArray.append(layoutHeader)
        //尾部
        layoutFooter = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, with: IndexPath(item: itemCount-1, section: 0))
        layoutFooter.frame = CGRect(x: 0, y: maxH, width: ConstantsHelp.SCREENWITH, height: footerHeight)
        attrsArray.append(layoutFooter)
    }
}

extension WaterfallLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArray
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: maxH + sectionInset.bottom - minimumLineSpacing  + footerHeight + topSpace)
    }
}



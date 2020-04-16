//
//  BaseSearchAndWaterfulController.swift
//  cryDemo
//
//  Created by 李桂盛 on 2020/4/1.
//  Copyright © 2020 LeeSin. All rights reserved.
//

import Foundation

//把需要自定义的部分抛出
public protocol BaseSearchAndWaterfulControllerDelegate {
  /*
     WaterfallLayoutDataSource
*/
    //高度比例
    func waterfallLayoutWith(index: IndexPath) -> CGFloat
    //几列
    func numberOfCols() -> Int
    
  /*
     UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
     */
    // 分区个数
    func numberOfSections() -> Int
    //每一个分区Item个数
    func numberOfItems(section: Int) -> Int
    // cell内容
    func cellForItem(indexPath: IndexPath) -> UICollectionViewCell
    //header
    func viewforSuppElementHeader(indexpath: IndexPath) -> UICollectionReusableView
    //footer
    func viewforSuppElementFotter(indexpath: IndexPath) -> UICollectionReusableView
    //selected
    func didSelected(indexpath: IndexPath)
    
  /*
     searchDelegate
    */
    func searchTextWith(text: String)
}



open class BaseSearchAndWaterfulController: BaseUIViewViewController {
    
    private var searchController:UISearchController = UISearchController(searchResultsController: nil)
    //MARK:-上一次的关键词
    private var lastSearchBarText:String = ""
    //MARK:-搜索框placeholder
    public var searchBarPlaceholder:String = ""
    //MARK:-填充的数据
    public var contentTitles: [[String : String]] = []
    public var headerTitleKey: String = ""
    public var imageName: String = ""
    //MARK:-搜索时可能需要添加的参数
    public var paramKey: String = "key"
    //容器
    public var collectionView: UICollectionView!
    //topSpace
    public var topSpace: CGFloat = 0
    //headerHeight
    public var headerHeight: CGFloat = 0
    //footerHeight
    public var footerHeight: CGFloat = 0
    //sectionInset
    public var sectionInset: UIEdgeInsets = .zero
    //代理
    public var delegate: BaseSearchAndWaterfulControllerDelegate!
    
    public var collectionViewBGColor: UIColor = .white

    public  let waterfallCell = "cell"
    public  let waterfallHeader = "header"
    public  let waterfallFooter = "footer"
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open func setupSearchAndWaterfulController() {
        
        let waterfulLayout = WaterfallLayout(topSpace: topSpace, headerHeight: headerHeight, footerHeight: footerHeight)
        waterfulLayout.sectionInset = sectionInset
        waterfulLayout.minimumLineSpacing = CGFloat(ConstantsHelp.normalPadding)
        waterfulLayout.minimumInteritemSpacing = CGFloat(ConstantsHelp.normalPadding)
        waterfulLayout.dataSource = self
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: waterfulLayout)
        collectionView.backgroundColor = collectionViewBGColor
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: waterfallCell)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: waterfallHeader)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: waterfallFooter)
        collectionView.delegate = self
        collectionView.dataSource = self
        baseView.addSubview(collectionView)
        
        //
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = searchBarPlaceholder
        if #available(iOS 11.0, *){
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            let uiView:UIView = UIView(frame: CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width,height: 45))
            uiView.addSubview(searchController.searchBar)
            searchController.searchBar.backgroundColor = ConstantsHelp.normalTableViewUIColor
            baseView.addSubview(uiView)
        }
        ///
        collectionView.snp.remakeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalToSuperview()
            } else {
                make.top.equalToSuperview().offset(45.0)
            }
        }
        //禁止🚫自动偏移
        self.automaticallyAdjustsScrollViewInsets = false
    }
}

extension BaseSearchAndWaterfulController: WaterfallLayoutDataSource {
    //高度比例
    func waterfallLayout(_ layout: WaterfallLayout, indexPath: IndexPath) -> CGFloat {
        return self.delegate.waterfallLayoutWith(index: indexPath)
    }
    func numberOfColsInWaterfallLayout(_ layout: WaterfallLayout) -> Int {
        return self.delegate.numberOfCols()
    }
    
}

extension BaseSearchAndWaterfulController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.delegate.numberOfSections()
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.delegate.numberOfItems(section: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.delegate.cellForItem(indexPath: indexPath)
    }
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            return self.delegate.viewforSuppElementHeader(indexpath: indexPath)
        } else {
            return self.delegate.viewforSuppElementFotter(indexpath: indexPath)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate.didSelected(indexpath: indexPath)
    }
    
}
//UISearchResultsUpdating
extension BaseSearchAndWaterfulController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        if let  searchBarText = searchController.searchBar.text {
            if searchBarText == "" && self.lastSearchBarText == ""{
                return
            }else{
                self.setupParamWith(value: searchBarText)
                self.lastSearchBarText = searchBarText
            }
        }
    }
    //MARK:-处理（添加或去掉搜索的参数）
    public func setupParamWith(value: String) {
//        if value == ""{
//             self.parameters.removeValue(forKey: paramKey)
//        }else{
//            self.parameters[paramKey] = value
//        }
        self.delegate.searchTextWith(text: value)
    }
    
}

//
//  ShowSegmentViewController.swift
//  topsiOSPro_Example
//
//  Created by 李桂盛 on 2019/11/28.
//  Copyright © 2019 李效晋. All rights reserved.
//

import UIKit
import topsiOSPro
import JXSegmentedView

/* 详细git地址：
 https://github.com/pujiaxin33/JXSegmentedView
 */
class ShowSegmentViewController: BaseUIViewViewController {

    let titles = ["猴哥", "青蛙王子", "旺财", "粉红猪", "喜羊羊", "黄焖鸡", "小马哥", "牛魔王", "大象先生", "神龙"]
    let vc = ContentBaseViewController()
    var itemTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vc.title = itemTitle
        
        //配置数据源
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titleSelectedColor = UIColor.red
        dataSource.isTitleZoomEnabled = true
        dataSource.titleSelectedZoomScale = 1.3
        dataSource.isTitleStrokeWidthEnabled = true
        dataSource.isSelectedAnimable = true
        dataSource.isItemWidthZoomEnabled = true
        dataSource.titles = titles
        vc.segmentedDataSource = dataSource
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

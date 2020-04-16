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
class ShowSegmentViewController: BaseSegmentedViewController {

    let titles = ["猴哥", "青蛙王子", "旺财", "粉红猪", "喜羊羊", "黄焖鸡", "小马哥", "牛魔王", "大象先生", "神龙"]
    let images = ["1", "2", "3", "4", "5", "6", "", "", "6", "2"]
    let dotStatesArray = [false, true, true, true, false, false, true, true, false, true]
    let numbersArray = [1, 22, 333, 44444, 0, 66, 777, 0, 99999, 10]
    var type = 1
    //选择tableview（列表）还是通用类型
    var isTableOrCommon: Bool = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var array: [String] = []
        
        for _ in titles{
            if isTableOrCommon {
                array.append("ListBaseViewController")
            } else {
                 array.append("ListBaseUIViewController")
            }
        }
        switch type {
        case 0:
            self.dataSourceType = .title
            self.indicatorType = .lengthen
            self.titleSelectedColor = .blue
            self.indicatorColor = .blue
            self.segmentTitles = titles
            self.listContainViewControllerStringArr = array
        case 1:
            self.dataSourceType = .titleAndImage
            self.indicatorType = .lengthen
            self.titleSelectedColor = .green
            self.indicatorColor = .green
            self.segmentTitles = titles
            self.segmentImages = images
            self.listContainViewControllerStringArr = array
        case 2:
            self.dataSourceType = .dot
            self.indicatorType = .lengthen
            self.titleSelectedColor = .purple
            self.indicatorColor = .purple
            self.segmentTitles = titles
            self.dotStates = dotStatesArray
            self.listContainViewControllerStringArr = array
        case 3:
            self.dataSourceType = .number
            self.indicatorType = .lengthen
            self.titleSelectedColor = .red
            self.indicatorColor = .red
            self.segmentTitles = titles
            self.numbers = numbersArray
            self.listContainViewControllerStringArr = array
        default:
            break;
        }
    }
}

class ShowSegmentListViewController:BaseUIViewViewController{
    
    lazy var tableView:UITableView = {
       let table = UITableView()
        table.delegate = self
        table.dataSource = self
        return table
    }()
    let types = [["纯文字","文字和图片","红点","数字"],
                ["更加通用的listContainner"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        setupUI()
    }
    func setupUI(){
        baseView.backgroundColor = .green
        baseView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    

}
extension ShowSegmentListViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return types.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = types[indexPath.section][indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    ///
        let vc = ShowSegmentViewController()
        vc.type = indexPath.row
        vc.isTableOrCommon = indexPath.section == 0 ? true : false
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

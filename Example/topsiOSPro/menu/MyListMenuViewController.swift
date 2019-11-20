//
//  MyListMenuViewController.swift
//  topsiOSPro_Example
//
//  Created by topscommmac01_lixiaojin on 2019/6/3.
//  Copyright © 2019 李效晋. All rights reserved.
//

import UIKit
import topsiOSPro
import QorumLogs

class MyListMenuViewController: BaseGroupedTableViewViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        QL1("viewDidLoad")
        self.valueDirect = [
            0:["本视图为tableview基本列表","点我展示collectionview","点我展示scrollview"],
            ] as [Int:[AnyObject]]
        
        self.imageDirect = [
        0:["AppIcon","AppIcon","AppIcon"],
        ] as [Int:[AnyObject]]
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            break;
        case 1:
            let viewcontroller = MyMenuViewController()
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        case 2:            
            let viewcontroller = MyScrollViewController()
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        default:
            break;
        }
    }


}

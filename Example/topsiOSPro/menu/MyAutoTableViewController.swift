//
//  MyAutoTableViewController.swift
//  topsiOSPro_Example
//
//  Created by 李桂盛 on 2019/11/20.
//  Copyright © 2019 李效晋. All rights reserved.
//

import UIKit
import topsiOSPro

class MyAutoTableViewController: BaseAutoTableViewListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        url = "http://172.20.3.53:8919/toa/" +
        "toa/toaRestaurantFood_foodList.json"
        
        itemContent = [["key":"name","value":"名称"],
                       ["key":"id","value":"标识"],
                       ["key":"records","value":"记录"]
        ]
        
    }
    

}

//
//  MyMenuViewController.swift
//  topsiOSPro_Example
//
//  Created by topscommmac01_lixiaojin on 2019/5/31.
//  Copyright © 2019 李效晋. All rights reserved.
//

import UIKit
import topsiOSPro

class MyMenuViewController: BaseMenuUICollectionViewViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.resourceArray = [
            ["title": "item1", "image": "AppIcon","num":"1"],
            ["title": "item2", "image": "AppIcon","num":"10"],
            ["title": "item3", "image": "AppIcon","num":"5"],
            ["title": "item4", "image": "AppIcon","num":"90"],
            ["title": "item5", "image": "AppIcon","num":"33"],
        ]
    }
    

}

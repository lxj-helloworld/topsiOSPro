//
//  ShowLocalImageViewController.swift
//  topsiOSPro_Example
//
//  Created by topscommmac01_lixiaojin on 2019/7/4.
//  Copyright © 2019 李效晋. All rights reserved.
//

import UIKit
import topsiOSPro
import SnapKit

class ShowLocalImageViewController: BaseUIViewViewController {
    
    let uiButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        uiButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        uiButton.setTitle("预览", for: .normal)
        self.baseView.addSubview(uiButton)
        uiButton.snp.makeConstraints { (make) in
            make.top.equalTo(ConstantsHelp.topMargin)
            make.left.equalTo(ConstantsHelp.leftMargin)
            make.right.equalTo(ConstantsHelp.rightMargin)
            make.height.equalTo(ConstantsHelp.buttonHeight)
        }
        
        uiButton.addTarget(self, action: #selector(showLocalImage), for: .touchDown)
        
    }
    

    @objc func showLocalImage(){
        var imageArr : [UIImage] = []
        imageArr.append(UIImage(named: "1")!)
        imageArr.append(UIImage(named: "2")!)
        imageArr.append(UIImage(named: "3")!)
        imageArr.append(UIImage(named: "4")!)
        imageArr.append(UIImage(named: "5")!)
        imageArr.append(UIImage(named: "6")!)
        
        let imagePreview = ImagePreviewViewController()
        imagePreview.imagesArr = imageArr
        
        self.navigationController?.pushViewController(imagePreview, animated: true)
    
        
    }

}

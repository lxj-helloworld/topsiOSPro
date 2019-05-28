//  CommonViews.swift
//  TopsProSys
//  Created by topscommmac01 on 2018/10/23.
//  Copyright © 2018年 com.topscommmac01. All rights reserved.
import Foundation
import UIKit
import SnapKit
import QorumLogs
import SwiftyJSON



public class CommonViews: NSObject{
    
    
    //获取横线
    public class func getLineView() -> UIView{
        let horizontalLine = UIView()
        horizontalLine.snp.makeConstraints { (make) in
            make.height.equalTo(0.9)
        }
        horizontalLine.backgroundColor = ConstantsHelp.normalBackgroundUIColor
        return horizontalLine
    }
    
    //分割线
    public class func getSeparatorUIView() -> UIView {
        let separatorUIView = UIView()
        separatorUIView.backgroundColor = ConstantsHelp.normalBackgroundUIColor
        separatorUIView.snp.makeConstraints { (make) in
            make.height.equalTo(CGFloat(ConstantsHelp.littlePadding))
            make.width.equalTo(ConstantsHelp.SCREENWITH)
        }
        return separatorUIView
    }
    
    //获取更小横向间隔
    public class func getLittleMarginView() -> UIView{
        let horizontalLine = UIView()
        horizontalLine.snp.makeConstraints { (make) in
            make.height.equalTo(2)
        }
        horizontalLine.backgroundColor = ConstantsHelp.normalBackgroundUIColor
        return horizontalLine
    }
    
    ///获取横向间隔
    public class func getMarginView() -> UIView{
        let horizontalLine = UIView()
        horizontalLine.snp.makeConstraints { (make) in
            make.height.equalTo(5)
        }
        horizontalLine.backgroundColor = ConstantsHelp.lightBackgroundUIColor
        return horizontalLine
    }
    
    //获取竖线
    public class func getVerticalLine() -> UIView{
        let verticalLine = UIView()
        verticalLine.snp.makeConstraints { (make) in
            make.width.equalTo(0.3)
        }
        verticalLine.backgroundColor = ConstantsHelp.deepBackgroundUIColor
        return verticalLine
    }
    
    //获取一般UILabel
    public class func getUILabel(title:String,width:Int = ConstantsHelp.leftTitleWidth) -> UILabel{
        let titleUILabel:UILabel = UILabel()
        titleUILabel.text = title
        titleUILabel.lineBreakMode = .byTruncatingMiddle
        titleUILabel.adjustsFontSizeToFitWidth = true
        titleUILabel.textAlignment = .right
        titleUILabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        titleUILabel.snp.makeConstraints { (make) in
            make.height.equalTo(ConstantsHelp.labelHeight)
            if width != 0{
                make.width.equalTo(width)
            }
        }
        return titleUILabel
    }
    
    //获取必填UILabel
    public class func getNotNullLabel(title:String,width:Int = ConstantsHelp.leftTitleWidth,titleColor:String = "#808080") -> UILabel{
        let titleUILabel:UILabel = UILabel()
        titleUILabel.lineBreakMode = .byTruncatingMiddle
        titleUILabel.adjustsFontSizeToFitWidth = true
        titleUILabel.textAlignment = .right
        titleUILabel.textColor = UIColor().hexStringToColor(hexString: titleColor, alpha: 1)
        titleUILabel.snp.makeConstraints { (make) in
            make.height.equalTo(ConstantsHelp.labelHeight)
            if width != 0{
              make.width.equalTo(width)
            }
        }
        let strg = "*" + title //全部文字
        let ranStr = "*" //需变色文字
        let attrstring:NSMutableAttributedString = NSMutableAttributedString(string:strg) //所有文字变为富文本
        let theRange = NSString(string: strg).range(of: ranStr)   //颜色处理的范围
        attrstring.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor.red, range: theRange)  //颜色处理
        titleUILabel.attributedText = attrstring   //赋值
        return titleUILabel
    }
    
    //获取需要显示内容UILabel,使用者自己定义尺寸
    public class func getCommentUILabel(title :String) -> UILabel{
        let titleUILabel:UILabel = UILabel()
        titleUILabel.text = title
        titleUILabel.lineBreakMode = .byTruncatingMiddle
        titleUILabel.adjustsFontSizeToFitWidth = true
        titleUILabel.textAlignment = .left
        titleUILabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return titleUILabel
    }
    
    //获取需要显示内容UILabel,使用者自己定义尺寸
    public class func getCommentGrayUILabel(title :String) -> UILabel{
        let titleUILabel:UILabel = UILabel()
        titleUILabel.text = title
        titleUILabel.lineBreakMode = .byTruncatingMiddle
        titleUILabel.adjustsFontSizeToFitWidth = true
        titleUILabel.textAlignment = .right
        titleUILabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        titleUILabel.snp.makeConstraints { (make) in
            make.height.equalTo(ConstantsHelp.labelHeight)
        }
        return titleUILabel
    }
    
    public class func getCommentGrayNoHeightUILabel(title :String) -> UILabel{
        let titleUILabel:UILabel = UILabel()
        titleUILabel.text = title
        titleUILabel.lineBreakMode = .byTruncatingMiddle
        titleUILabel.adjustsFontSizeToFitWidth = true
        titleUILabel.textAlignment = .right
        titleUILabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return titleUILabel
    }
    
    //获取需要显示内容UILabel,使用者自己定义尺寸
    public class func getCommentGrayNotNullUILabel(title:String,titleColor:String = "#808080") -> UILabel{
        let titleUILabel:UILabel = UILabel()
        titleUILabel.text = title
        titleUILabel.lineBreakMode = .byTruncatingMiddle
        titleUILabel.adjustsFontSizeToFitWidth = true
        titleUILabel.textAlignment = .right
        titleUILabel.textColor = UIColor().hexStringToColor(hexString: titleColor, alpha: 1)
        titleUILabel.snp.makeConstraints { (make) in
            make.height.equalTo(ConstantsHelp.labelHeight)
        }
        let strg = "*" + title //全部文字
        let ranStr = "*" //需变色文字
        let attrstring:NSMutableAttributedString = NSMutableAttributedString(string:strg) //所有文字变为富文本
        let theRange = NSString(string: strg).range(of: ranStr)   //颜色处理的范围
        attrstring.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor.red, range: theRange)  //颜色处理
        titleUILabel.attributedText = attrstring   //赋值
        return titleUILabel
    }
    
    //获取右侧TextField
    public class func getUITextFeild() -> UITextField{
        let uiTextField = UITextField()
        uiTextField.clearButtonMode = .whileEditing
        uiTextField.returnKeyType = .done
        uiTextField.borderStyle = .roundedRect
        uiTextField.layer.borderColor = ConstantsHelp.borderCGColor
        uiTextField.adjustsFontSizeToFitWidth = true
        uiTextField.layer.borderWidth = 0.5
        uiTextField.layer.cornerRadius = 5
        uiTextField.backgroundColor = ConstantsHelp.backgroundUIColor
        uiTextField.snp.makeConstraints { (make) in
            make.height.equalTo(ConstantsHelp.uiTextFieldHeight)
        }
        return uiTextField
    }

    //获取较高TextField
    public class func getBiggerEditUITextView() -> UITextView{
        let editUiTextView = UITextView()
        editUiTextView.font = UIFont.systemFont(ofSize: ConstantsHelp.smallFontSize)
        editUiTextView.layer.borderColor = ConstantsHelp.borderCGColor
        editUiTextView.returnKeyType = .done
        editUiTextView.layer.borderWidth = 0.5
        editUiTextView.layer.cornerRadius = 5
        editUiTextView.textColor = UIColor.black
        editUiTextView.backgroundColor = ConstantsHelp.backgroundUIColor
        editUiTextView.snp.makeConstraints { (make) in
            make.height.equalTo(ConstantsHelp.uiTextFieldBigHeight)
        }
        return editUiTextView
    }
    
    
    //获取右侧值UILabel
    public class func getRightUILabel(title :String) -> UILabel{
        let titleUILabel:UILabel = UILabel()
        titleUILabel.text = title
        titleUILabel.lineBreakMode = .byTruncatingMiddle
        titleUILabel.textAlignment = .left
        return titleUILabel
    }
    
    //获取一般按钮
    public class func getPickUIButton(_ title :String) -> UIButton{
        let normalUIButton:UIButton = UIButton()
        normalUIButton.setTitle(title, for: .normal)
        normalUIButton.setTitleColor(ConstantsHelp.fontNormalUIColor, for: .normal)
        normalUIButton.layer.borderColor = ConstantsHelp.borderCGColor
        normalUIButton.layer.borderWidth = 0.5
        normalUIButton.layer.cornerRadius = 5
        normalUIButton.layer.backgroundColor = ConstantsHelp.lightBackgroundCGColor
        normalUIButton.titleLabel?.adjustsFontSizeToFitWidth = true
        if #available(iOS 9.0, *) {
            normalUIButton.semanticContentAttribute = .forceRightToLeft
        } else {
            // Fallback on earlier versions
        }
        normalUIButton.snp.makeConstraints { (make) in
            make.height.equalTo(ConstantsHelp.uiTextFieldHeight)
        }
        return normalUIButton
    }
    
    //获取停止按钮
    public class func getCancleUIButton(_ title :String) -> UIButton{
        let normalUIButton:UIButton = UIButton()
        normalUIButton.setTitle(title, for: .normal)
        normalUIButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        normalUIButton.layer.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        normalUIButton.layer.borderColor = ConstantsHelp.borderCGColor
        normalUIButton.layer.borderWidth = 0.5
        normalUIButton.layer.cornerRadius = 5
        normalUIButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
        }
        return normalUIButton
    }
    
    
    ///获取提交按钮
    public class func getSubmitUIButton(_ title :String) -> UIButton{
        let normalUIButton:UIButton = UIButton()
        normalUIButton.setTitle(title, for: .normal)
        normalUIButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        normalUIButton.layer.backgroundColor = ConstantsHelp.mainCGColor
        normalUIButton.layer.borderColor = ConstantsHelp.borderCGColor
        normalUIButton.layer.borderWidth = 0.5
        normalUIButton.layer.cornerRadius = 5
        normalUIButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
        }
        return normalUIButton
    }
   
    
    //获取填写信息部分，左侧title，右侧文本框
    public class func getTextFieldInfoView(dataMap:JSON,titles:[[String:String]]) -> UIView{
        let infoView = UIView()
        var titleLeft = UILabel()
        var valueRight = UITextField()
        for (index,value) in titles.enumerated() {
            titleLeft = UILabel()
            titleLeft.lineBreakMode = .byTruncatingMiddle
            titleLeft.text = value["value"]! + NSLocalizedString("colon",comment:"")
            titleLeft.textAlignment = .right
            titleLeft.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            infoView.addSubview(titleLeft)
            titleLeft.snp.makeConstraints{(make) -> Void in
                make.left.equalTo(0)
                make.top.equalTo(ConstantsHelp.labelHeight * index)
                make.height.equalTo(ConstantsHelp.labelHeight)
                make.width.equalTo(ConstantsHelp.leftTitleWidth)
            }
            valueRight = UITextField()
            valueRight.text = dataMap[value["key"]!].stringValue
            valueRight.placeholder = "2"
            valueRight.returnKeyType = .done
            
            infoView.addSubview(valueRight)
            valueRight.snp.makeConstraints{(make) -> Void in
                make.left.equalTo(ConstantsHelp.leftTitleWidth)
                make.top.equalTo(ConstantsHelp.labelHeight * index)
                make.height.equalTo(ConstantsHelp.labelHeight)
            }
            let horizontalLine = getLineView()
            infoView.addSubview(horizontalLine)
            horizontalLine.snp.makeConstraints{(make) -> Void in
                make.left.equalTo(ConstantsHelp.leftMargin)
                make.width.equalTo(ConstantsHelp.SCREENWITH)
                make.top.equalTo(ConstantsHelp.labelHeight * (index + 1))
            }
        }
        infoView.snp.makeConstraints { (make) in
            make.bottom.equalTo(valueRight.snp.bottom).offset(ConstantsHelp.littlePadding)
        }
        
        return infoView
    }
   
   
   
}

//
//  ConstantsHelp.swift
//  Alamofire
//
//  Created by topscommmac01_lixiaojin on 2019/5/28.
//

import Foundation
import UIKit

class ConstantsHelp: NSObject {
    
    //当前设备屏幕宽度
    static let SCREENWITH = UIScreen.main.bounds.width
    //当前设备屏幕的高度
    static let SCREENHEIGHT = UIScreen.main.bounds.height
    
    static let IPHONESMALLWIDTH:CGFloat = 320 //iphone较小宽度
    static let IPHONEMIDDLEWIDTH:CGFloat = 375 //iphone中间宽度
    static let IPHONEBIGWIDTH:CGFloat = 414 //iphoneo较大宽度
    
    //用户名和密码输入框高度
    static let textFieldLoginHeight = 45
    static let textFieldHeight = 35
    static let detailInfoHieght = 25
    
    
    //较小字体大小
    static let smallerFontSize:CGFloat = 12
    //较小字体大小
    static let littleFontSize:CGFloat = 15
    //较大字体大小
    static let smallFontSize:CGFloat = 17
    //普通字体大小
    static let normalFontSize:CGFloat = 19
    //较大大字体大小
    static let largeFontSize:CGFloat = 25
    //行间距
    static let lineSpaceNormal = 8
    //内边距
    static let normalPadding = 10
    //较小内边距
    static let littlePadding = 5
    //较大内边距
    static let largePadding = 15
    //label高度
    static let labelHeight = 35
    //较小label高度
    static let middleLabelHeight = 25;
    //文本框
    static let uiTextFieldHeight = 35
    //较大文本框
    static let uiTextFieldBigHeight = 70
    //title高度
    static let titleHeight = 35
    //较小Label高度
    static let littleLabelHeight = 20
    //视图顶部边距
    static let topMargin = 10
    //视图左边距
    static let leftMargin = 10
    //视图右边距
    static let rightMargin = -10
    //左侧标签宽度,六个字左右宽度
    static let leftTitleWidth = 110
    //左侧较小标签宽度,四个字左右宽度
    static let leftTitleSmallWidth = 70
    //左侧必填标签宽度,四个字左右宽度
    static let leftTitleNotNullWidth = 80
    //按钮高度
    static let buttonHeight = 35
    //item 每行高度
    static let itemRowHeight = 35
    
}


//网络响应数据参数名称
extension ConstantsHelp{
    static let actionReuslt:String = "actionResult"
    static let message:String = "message"
    static let success:String = "success"
    static let timeout:String = "timeout"
    static let dataMap:String = "dataMap"
    static let mobile:String = "mobile"
    static let loginName:String = "LoginName"
    static let uuid: String = "uuid"
    static let dataList:String = "dataList"
    static let listDataMap:String = "listDataMap"
}

//颜色部分
extension ConstantsHelp {
    static let backgroundCGColor:CGColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let borderCGColor:CGColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    static let fontNormalCGColor:CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let mainCGColor:CGColor = CGColor.CGColorFromRGB(rgbValue: 0x058bd6)
    static let deepBackgroundCGColor:CGColor = CGColor.CGColorFromRGB(rgbValue: 0xbbbbbb)
    static let lightBackgroundCGColor:CGColor = CGColor.CGColorFromRGB(rgbValue: 0xEEEEEE)
    static let normalBackgroundCGColor:CGColor = CGColor.CGColorFromRGB(rgbValue: 0xF6F6F6)
    static let backgroundUIColor:UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let buttonUIColor:UIColor = UIColor.colorWithHexString(hex:"#30AAFF")
    static let borderUIColor:UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    static let fontNormalUIColor:UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let fontGreyUIColor:UIColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    static let fontItemLabelColor:UIColor = UIColor.colorWithHexString(hex: "#333333")
    static let normalTableViewUIColor:UIColor = UIColor.colorWithHexString(hex:"#efeff4")
    static let normalMainUIColor:UIColor = UIColor.colorWithHexString(hex:"#058bd6")
    static let mainUIColor:UIColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    static let normalBtnColor = UIColor.colorWithHexString(hex:"#30AAFF")
    static let darkMainUIColor:UIColor = UIColor.colorWithHexString(hex:"#0683c9")
    static let deepBackgroundUIColor:UIColor = UIColor.colorWithHexString(hex:"#bbbbbb")
    static let lightBackgroundUIColor:UIColor = UIColor.colorWithHexString(hex:"#EEEEEE")
    static let normalBackgroundUIColor:UIColor = UIColor.colorWithHexString(hex:"#F6F6F6")
    static let normalTextUIColor:UIColor = UIColor.colorWithHexString(hex:"#696969")
    static let stateUIColor:UIColor = UIColor.colorWithHexString(hex: "#009e49")
    static let loginUIColor:UIColor = UIColor.colorWithHexString(hex: "#202020")
    static let tintColor:UIColor = UIColor.colorWithHexString(hex: "#202020")
}

extension ConstantsHelp{
    //分页参数
    static let pageTitle = "page"
    static let rowsTitle = "rows"
    static let rows = 20
    static let sidxTitle = "sidx"
    static let sordTitle = "sord"
    static let stateTitle = "state"
    static let indexAppTitle = "indexApp"
    static let typeListTitle = "typeList"
    
    static let asc = "asc"
    static let desc = "desc"
    static let sortcode = "sortcode"
    static let approvalUserId = "approvalUserId"
    
    //审批状态
    static let stateToDo = "1" //审核中，待办
    static let stateAlreadyDo = "2,3,8" //通过，不通过，关闭
    static let stateDenyDo = "9" // 退回
    
    //审批节点状态
    static let openState = "0" //开立,未启动
    static let approvingState = "1" //审核中
    static let approveState = "2" //审批通过
    static let disApproveState = "3" //审批不通过
    static let submitState = "4" //已提交
    static let closeState = "8" //关闭状态
    
    //单据状态
    static let billOpenState = "0" //开立,未启动
    static let billApproveState = "1" //审核中
    static let billBackState = "2" // 退回
    static let billEndState = "9" //已审核
    
    
    //页面状态
    static let add = "add"
    static let update = "update"
    
}


extension ConstantsHelp{
    //详情以及列表属性部分
    static let unit = "unit"
    static let color = "color"
    static let money = "money"
    static let isAllowNull = "isAllowNull"
    static let isAllowZero = "isAllowZero"
    static let no = "no"
    
    static let bit = "bit"
    
    static let man = "人"
    static let day = "天"
    static let yuan = "元"
    static let red = "#FF0000"
    static let green = "#37562c"
    static let yellow = "#FF8000"
    static let dateType = "dateType"
    static let date = "date" //只保留日期 2019-01-01
    static let time = "time" //保留到时间 2019-01-01 12:00:00
    static let dateHour = "dateHour" //保留到日期小时 2019-01-01 12:00
    static let hour = "hour" //保留小时分钟 12:00
    static let topsProColor = "topsProColor"
    
    //其余部分
    static let crmCookie = "crmCookie"
    static let OA = "OA"
    static let CRM = "CRM"
    static let ER = "ER"
    static let approvalHistory = "approvalHistory"
    static let applyHistory = "applyHistory"
    
    static let attachmentList = "attachmentList"
    static let mainTable = "mainTable"
    static let lineTable = "lineTable"
    static let lineTableOne = "lineTableOne"
    
    static let imageStr =  ".JPG.PNG.GIF.JPEG.jpg.png.gif.jpeg.HEIC.heic.HEIF.heif"
    static let key = "key"
    static let value = "value"
    static let disTitle = "disTitle"
    static let title = "title"
    static let code = "code"
    static let image = "image"
    static let lineTableKey = "lineTableKey"
    
    static let cannotRead = ".zip.rar.exe" //暂时不支持在线预览文件类型
    static let imageCount = 9 //图片预览时 超过该数以文字显示
    static let fileTableViewCount = 0 //附件列表超过该数时 滚动条常在
    
    static let dept = "dept" //部门
    static let user = "人员" //人员
    static let usercode = "usercode" //工号
}

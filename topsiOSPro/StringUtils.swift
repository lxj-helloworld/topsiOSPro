//
//  StringUtils.swift
//  FBSnapshotTestCase
//
//  Created by topscommmac01_lixiaojin on 2019/5/27.
//

import Foundation


class StringUtils: NSObject {
    //获取字符串的前N个字符串
    class func getPrefixNStr(currentStr :String,length : Int) -> String {
        var strResult = ""
        if currentStr == "" || currentStr.count < length{
            strResult = currentStr
        }else {
            strResult = String(currentStr.prefix(length))
        }
        return strResult
    }
    
    //获取字符串的后N个字符串
    class func getSuffixNStr(currentStr :String,length : Int) -> String {
        var strResult = ""
        if currentStr == "" || currentStr.count < length{
            strResult = currentStr
        }else {
            strResult = String(currentStr.suffix(length))
        }
        return strResult
    }
    
    //截取字符串,按开始、结束位截取
    class func getIndexStr(currentStr:String,start:Int,end:Int) -> String {
        var str = ""
        if currentStr == "" || currentStr.count < end {
            str = currentStr
        }else{
            let startStr = currentStr.index(currentStr.startIndex, offsetBy: start)
            let endStr = currentStr.index(currentStr.startIndex, offsetBy: end)
            str = String(currentStr[startStr..<endStr])
        }
        return str
    }
    
    // 获取指定高度字符串宽度
//    class func getStrWidth(str:String,fontSize: CGFloat, height:CGFloat = ConstantsHelp.SCREENHEIGHT) -> CGFloat {
//        let font = UIFont.systemFont(ofSize: fontSize)
//        let rect = NSString(string: str).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
//        return rect.width
//    }
    
    // 获取最后一个指定符号后面的信息
    class func getSignBackStr(str:String,sign:String = "\\") -> String {
        var result = ""
        if str == "" || !str.contains(sign){
            result = str
        }else{
            let list = str.components(separatedBy: sign)
            result = String(list[list.count-1])
        }
        return result
    }
    
    //保留小数点后n位小数
    class func decimalHold(_ Str:String,_ number:Int,_ isForce:Bool) -> String{
        var tempStr = ""
        if !isForce{
            if Str.contains("."){
                if Str.split(separator: ".")[1].count >= number{
                    tempStr = Str.split(separator: ".")[0] + "." + getPrefixNStr(currentStr: String(Str.split(separator: ".")[1]), length: number)
                }else{
                    tempStr = Str
                }
            }else{
                tempStr = Str
            }
        }else{
            if Str.contains("."){
                if Str.split(separator: ".")[1].count >= number{
                    tempStr = Str.split(separator: ".")[0] + "." + getPrefixNStr(currentStr: String(Str.split(separator: ".")[1]), length: number)
                }else{
                    let num = number - Str.split(separator: ".")[1].count
                    tempStr = Str
                    for _ in 1...num{
                        tempStr = tempStr + "0"
                    }
                }
            }else{
                tempStr = Str+"."
                for _ in 1...number{
                    tempStr = tempStr + "0"
                }
            }
        }
        return tempStr
    }
    
    //字符串进行md5摘要加密
//    class func md5(_ strs:String) ->String{
//        let str = strs.cString(using: String.Encoding.utf8)
//        let strLen = CUnsignedInt(strs.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//        CC_MD5(str!, strLen, result)
//        let hash = NSMutableString()
//        for i in 0 ..< digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        result.deinitialize(count: 1)
//        return String(format: hash as String)
//    }
    
    //字符串转字典
    class func toDictionary(_ str:String) ->NSDictionary{
        let jsonData:Data = str.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
}

extension String{
    // 字符串转 CGFloat
    func toCGFloat() -> CGFloat {
        var float:CGFloat = 0
        if VerifyHelp.isPurnFloat(string: self){
            let double = Double(self)
            if double != nil {
                float = CGFloat(double!)
            }
        }
        return float
    }
    
    //字符串转富文本
    func toNSAttributedString() ->NSAttributedString{
        var result:NSAttributedString = NSAttributedString.init(string: "")
        do{
            result = try NSAttributedString(data: self.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            
        }catch let error as NSError {
            QL1(error)
            result = NSAttributedString.init(string: "")
        }
        return result
    }
    
}


//
//  BaseGroupedTableViewViewController.swift
//  topsiOSPro
//
//  Created by topscommmac01_lixiaojin on 2019/6/3.
//

import UIKit
import QorumLogs

class BaseGroupedTableViewViewController: BaseUIViewViewController,UITableViewDelegate,UITableViewDataSource  {
    
    var tableView:UITableView!
    var valueDirect:[Int:[AnyObject]] = [:]
    var imageDirect:[Int:[AnyObject]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initOthers()
        initTableView()
    }
    
    func initOthers(){
        
    }
    
    func initTableView() {
        tableView = UITableView(frame:baseView.frame, style:.grouped)
        baseView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(baseView)
        }
        locationTableView()
    }
    
    func locationTableView() {
        tableView.snp.makeConstraints { (make) in
            // 避免ios11.0以下系统 页面自动向下偏移64px
            if #available(iOS 11.0, *){
                make.top.equalToSuperview()
            }else{
                make.top.equalTo(view.snp.top)
            }
        }
    }
    
    //返回分组个数
    func numberOfSections(in tableView: UITableView) -> Int {
        return valueDirect.count
    }
    
    
    //自定义header视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    //设置分组头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(ConstantsHelp.littlePadding)
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    //自定义footer视图
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    //每一组的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (valueDirect[section]?.count)!
    }
    
    //将要点击
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    //点击后 重写该方法，处理点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        QL1("indexPath.section = \(indexPath.section) , indexPath.row = \(indexPath.row)")
    }
    
    //每行的视图 重写该方法，定制每行显示的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        QL1("定制每行视图 in BaseGroupedTableViewViewController")
        return UITableViewCell()
    }
}

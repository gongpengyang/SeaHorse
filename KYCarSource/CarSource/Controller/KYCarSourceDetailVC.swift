//
//  KYCarSourceDetailVC.swift
//  HelloWorld
//
//  Created by gongpengyang on 2019/2/15.
//  Copyright © 2019 gongpengyang. All rights reserved.
//

import UIKit

class KYCarSourceDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var m_tableView: UITableView!
    
    //发往地,地址选择视图
    lazy var m_addressSelectorView = { () -> KYAddressSelectorView in
        let view = KYAddressSelectorView.loadFromNib()
        return view
    }()
    //存储数据model
    lazy var m_model:KYCarSourcePrivateModel = {
        let model = KYCarSourcePrivateModel()
        return model
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "车源详情"
        let barButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightBarButtonItemAction))
        barButtonItem.tintColor = TSColor.button.yellowSelected
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        self.initUI()
    }
    
    lazy var m_titles:[String] = {
        return ["车牌号:",
                "车长类型:",
                "车主姓名:",
                "联系电话:"]
    }()
    lazy var m_placeholders:[String] = {
        return ["请填写车牌号",
                "请选择车长类型",
                "请填写姓名",
                "请填写联系电话"]
    }()
    
    
    private func initUI() {
        
        m_tableView.delegate = self
        m_tableView.dataSource = self
        m_tableView.backgroundColor = UIColor.init(red: 241, green: 240, blue: 246, alpha: 1)
        m_tableView.register(UINib(nibName: "KYCarSourceDetailCell", bundle: nil), forCellReuseIdentifier: "KYCarSourceDetailCell")
        m_tableView.tableHeaderView = tableHeaderView()
        m_tableView.tableFooterView = tableFooterView()
        
        
    }
    //上部分视图
    func tableHeaderView() -> UIView {
        let m_width = UIScreen.main.bounds.width
        
        //承载view
        let m_tableHeaderView = UIView.init(frame: CGRect(x:0, y:0, width:m_width, height:175))
        
        //发往地
        let view = KYCarSourceDetailHeaderView.init(frame: CGRect(x:0, y:0, width:m_width, height:80))
        view.m_titleLable.text = "请选择初始地"
        view.m_titleLable.textColor = TSColor.cell.placeholder
        view.buttonCallBack = {
            
            self.m_addressSelectorView.show()
            self.m_addressSelectorView.getAddressCallBack = {
                (model:KYAddressModel) -> () in
                let provice = model.provice ?? ""
                let city = model.city ?? ""
                let area = model.area ?? ""
                let title:String?  = "\(provice) \(city) \(area)"
                if !provice.isEmpty {
                    view.m_titleLable.text = title
                }
            }
        }
        m_tableHeaderView.addSubview(view)
        
        //返回地
        let view1 = KYCarSourceDetailHeaderView.init(frame: CGRect(x:0, y:view.frame.height, width:m_width, height:80))
        view1.m_titleLable.text = "请选择返回地"
        view1.m_titleLable.textColor = TSColor.cell.placeholder
        view1.m_BottomLine.isHidden = true
        view1.buttonCallBack = {
            print("闭包回调1")
        }
        m_tableHeaderView.addSubview(view1)
        
        //分割条
        let m_bottomBar = UIView.init(frame: CGRect(x:0, y:160, width:m_width, height:15))
        m_bottomBar.backgroundColor = UIColor.green
        m_tableHeaderView.addSubview(m_bottomBar)
        
        return m_tableHeaderView
        
    }
    //下部分视图
    func tableFooterView() -> UIView {
        
        
        let m_width = UIScreen.main.bounds.width
        //承载view
        let m_tableFooterView = UIView.init(frame: CGRect(x:0, y:0, width:m_width, height:95))
        
        //分割条
        let m_topBar = UIView.init(frame: CGRect(x:0, y:0, width:m_width, height:15))
        m_topBar.backgroundColor = UIColor.green
        m_tableFooterView.addSubview(m_topBar)
        
        
        let view = KYCarSourceDetailFooterView.init(frame: CGRect(x:0, y:15, width:m_width, height:80))
        view.buttonCallBack = {
            print("闭包回调")
        }
        m_tableFooterView.addSubview(view)
        
        return m_tableFooterView
        
    }
    
    // MARK: - tableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return m_titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        return UITableView.automaticDimension;
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KYCarSourceDetailCell", for: indexPath) as? KYCarSourceDetailCell
        cell?.m_titleLable.text = m_titles[indexPath.row]
        cell?.m_contentLabel.placeholder = m_placeholders[indexPath.row]
        cell?.m_rightImage.isHidden = true
        switch indexPath.row {
        case 0:
            break
        case 1:
            cell?.m_rightImage.isHidden = false
            cell?.m_contentLabel.isEnabled = false
            cell?.m_contentLabel.text = self.m_model.carLongType
            break
        case 2:
            break
        case 3:
            break
            
        default:
            break
            
        }
        return cell!
        
    }
    
    // MARK: - didSelectRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            break
            
        case 1:
            let vc = KYCarTypeVC(nibName:"KYCarTypeVC",bundle:nil)
            vc.getCarDatasCallBack = {
                (longs:Array<String>,types:Array<String>) -> ()in
                self.m_model.carLongType = longs[0]+","+types[0]
                self.m_tableView.reloadData()
                
            }
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        default:
            break
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    
    //导航右侧保存
    @objc func rightBarButtonItemAction(){
        
    }
    
    
    
}

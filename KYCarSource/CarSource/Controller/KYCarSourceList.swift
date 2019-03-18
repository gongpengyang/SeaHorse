//
//  KYCarSourceList.swift
//  HelloWorld
//
//  Created by gongpengyang on 2019/2/13.
//  Copyright © 2019 gongpengyang. All rights reserved.
//

import UIKit

class KYCarSourceList: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var m_tableView: UITableView!
    
    var m_button:UIButton?
    
    lazy var m_titles:[KYCarSourcePrivateModel] = {
        let model = KYCarSourcePrivateModel()
        let model1 = KYCarSourcePrivateModel()
        let model2 = KYCarSourcePrivateModel()
        let model3 = KYCarSourcePrivateModel()
        
        return [model,
                model1,
                model2,
                model3]
    }()
    
    //    lazy var m_model = { () -> KYCarSourcePrivateModel in
    //        let model = KYCarSourcePrivateModel()
    //        return model
    //    }()
    
    //底部确认发送
    
    var m_bottomBarView:KYBottomBarView?
    
    override func viewDidLoad() {
        title = "我的车源"
        
        let barButtonItem = UIBarButtonItem(title: "新建车源", style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightBarButtonItemAction))
        barButtonItem.tintColor = TSColor.button.yellowSelected
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        self.initUI()
        
        
    }
    
    @objc func rightBarButtonItemAction(){
        
    }
    
    private func initUI() {
        m_tableView.delegate = self
        m_tableView.dataSource = self
        m_tableView.register(UINib(nibName: "KYCarSourceListCell", bundle: nil), forCellReuseIdentifier: "cell")
        m_bottomBarView = KYBottomBarView.init()
        m_bottomBarView?.m_title = "确认发送"
        m_bottomBarView?.m_color = TSColor.button.disabled
        m_bottomBarView?.isUserInteractionEnabled = false
        m_bottomBarView?.buttonCallBack = {
            print("闭包回调123")
            
        }
        m_tableView.tableFooterView = m_bottomBarView
    }

    
    // MARK: - tableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return m_titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        return UITableView.automaticDimension;
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? KYCarSourceListCell
        cell?.buttonCallBack = {
            self.selectButtonClick(m_indexPath: indexPath,m_cell: cell!)
        }
        let model = self.m_titles[indexPath.row]
        if model.isLSelect {
            cell?.m_leftImageVIew.backgroundColor = UIColor.red
        }else {
            cell?.m_leftImageVIew.backgroundColor = UIColor.black
        }
        return cell!
        
    }
    
    // MARK: - didSelectRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
                let vc = KYCarSourceDetailVC(nibName:"KYCarSourceDetailVC",bundle:nil)
                self.navigationController?.pushViewController(vc, animated: true)
        
    }
    //MARK:左侧选择
    fileprivate  func selectButtonClick(m_indexPath:IndexPath,m_cell:KYCarSourceListCell) {
        var  isTrue:Bool = false
        
        for (i,item) in self.m_titles.enumerated() {
            if i==m_indexPath.row {
                item.isLSelect = !item.isLSelect
                if item.isLSelect {
                    isTrue = true
                }
       
            }else{
                item.isLSelect = false
 
            }
        }
        if isTrue {
            m_bottomBarView?.m_color = TSColor.button.yellowSelected
        }else {
            m_bottomBarView?.m_color = TSColor.button.disabled
            
        }
        m_bottomBarView?.isUserInteractionEnabled = isTrue
        m_tableView.reloadData()
    }
    
    
}

//
//  KYCarTypeVC.swift
//  KYCarSource
//
//  Created by gongpengyang on 2019/3/7.
//  Copyright © 2019 gongpengyang. All rights reserved.
//isSupply 配置车源 货源参数

import UIKit

class KYCarTypeVC: UIViewController {
    
    
    @IBOutlet weak var m_collectionView: UICollectionView!
    
    weak var m_collectionHeader: KYCarTypeHeader!
    
    //回调数组 车长
    var m_callLongDatas:[String]! = []
    
    //回调数组 车型
    var m_callTypeDatas:[String]! = []
    
    /**
     外部回调闭包
     2个arr分别存储车长和车型
     */
    var getCarDatasCallBack:((_ longs:Array<String>,_ types:Array<String>) -> ())?
    
    
    /** 车源,货源判断,默认车源 */
    var isSupply:Bool = false {
        didSet {
            if isSupply {
                
                let model:KYCarTypeModel = KYCarTypeModel()
                model.title = "不限"
                let model1:KYCarTypeModel = KYCarTypeModel()
                model1.title = "不限"
                
                m_numberTitles.insert(model, at: 0)
                m_typeTitles.insert(model1, at: 0)
                
            }
        }
    }
    
    lazy var m_numberTempTitles:[String] = {
        return [
            "2.7",
            "3.8",
            "4.2",
            "5",
            "6.2",
            "6.8",
            "7.7",
            "8.2",
            "8.7",
            "9.6",
            "11.7",
            "12.5",
            "13",
            "15",
            "16",
            "17.5"]
    }()
    
    lazy var m_typeTempTitles:[String] = {
        return [
            "高栏",
            "厢式",
            "危险品",
            "自卸",
            "冷藏",
            "保温",
            "高地板",
            "面包车",
            "棉被车",
            "爬梯车",
            "飞翼车",
            "平板"]
    }()
    
    /**
     车型内容数组
     暂时写成固定,如果网络获取直接外部赋值即可
     */
    lazy var m_typeTitles:[KYCarTypeModel] = {
        () -> [KYCarTypeModel] in
        
        var tempArr:[KYCarTypeModel] = []
        for (index, item) in self.m_typeTempTitles.enumerated()  {
            let model:KYCarTypeModel = KYCarTypeModel()
            model.title = item
            tempArr.append(model)
        }
        return tempArr
    }()
    
    /**
     车长内容数组
     暂时写成固定,如果网络获取直接外部赋值即可
     */
    lazy var m_numberTitles:[KYCarTypeModel] = {
        () -> [KYCarTypeModel] in
        
        var tempArr:[KYCarTypeModel] = []
        for (index, item) in self.m_numberTempTitles.enumerated()  {
            let model:KYCarTypeModel = KYCarTypeModel()
            model.title = item
            tempArr.append(model)
        }
        return tempArr
    }()
    
    weak var m_bottomBarView:KYBottomBarView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "车长类型"
        initUI()
    }
    
    func initUI() {
        
        m_collectionView.delegate = self
        m_collectionView.dataSource = self
        m_collectionView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)//底部添加一个视图 作为collectionFooterView使用
        m_collectionView.showsVerticalScrollIndicator = true // 消除右侧滚动条
        m_collectionView.register(UINib.init(nibName: "KYCarTypeCell", bundle: nil), forCellWithReuseIdentifier: "KYCarTypeCell")
        m_collectionView?.register(KYCarTypeHeader.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        m_collectionView?.register(KYBottomBarView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView")
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:ScreenWidth/4-15,height:(ScreenWidth/4-15)/2.105)
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15)
        m_collectionView.collectionViewLayout = layout
        
        let view = KYBottomBarView.init(frame: CGRect(x:0, y:ScreenHeight-100, width:ScreenWidth, height:100))
        self.m_bottomBarView = view
        view.m_color = TSColor.button.disabled
        view.m_disabled = false
        view.m_title = "确认"
        view.buttonCallBack = {
            if self.getCarDatasCallBack != nil {
                self.getCarDatasCallBack!(self.m_callLongDatas,self.m_callTypeDatas)
            }
            self.navigationController?.popViewController(animated: true)
        }
        self.view.addSubview(view)
        
    }
    //MARK:车源按钮点击后样式,数据联动
    func carDidSelectItemStatus(indexPath: IndexPath){
        
        
        switch indexPath.section {
        case 0:
            m_callLongDatas.removeAll()
            for (index, item) in self.m_numberTitles.enumerated()  {
                if indexPath.row == index {
                    item.isSelected = true
                    m_callLongDatas.append(item.title ?? "未选择车长")
                }else {
                    item.isSelected = false
                }
            }
            break
        case 1:
            m_callTypeDatas.removeAll()
            for (index, item) in self.m_typeTitles.enumerated()  {
                if indexPath.row == index {
                    item.isSelected = true
                    m_callTypeDatas.append(item.title ?? "未选择车型")
                }else {
                    item.isSelected = false
                }
            }
            break
            
        default:
            break
        }
        
        monitorSelectedDatas()
        m_collectionView.reloadData()
        
        
    }
    //MARK:货源按钮点击后样式,数据联动
    func supplyDidSelectItemStatus(indexPath: IndexPath){
        
        switch indexPath.section {
        case 0:
            m_callLongDatas.removeAll()
            //标识选择的item
            var maxCount:NSInteger = 0
            
            for (index, item) in self.m_numberTitles.enumerated()  {
                if indexPath.row == index {//设置取消选中状态
                    item.isSelected = !item.isSelected
                }
            }
            
            //找到已被选择item
            for (_, item) in self.m_numberTitles.enumerated()  {
                if item.isSelected {//并记录
                    maxCount += 1
                }
                if maxCount>3 {//当记录大于3给出提示 跳出循环
                    for (index, item) in self.m_numberTitles.enumerated()  {//把当前已经点击的item重新设置为未选择状态
                        if indexPath.row == index {
                            item.isSelected = false
                        }
                        
                    }
                    //回调数据整理
                    for (_, item) in self.m_numberTitles.enumerated()  {//找到已被选择item
                        if item.isSelected {//
                            m_callLongDatas.append(item.title ?? "车长未选择")
                        }
                    }
                    print("最多可选择三个车长!")
                    return
                }
            }
            //回调数据整理
            for (_, item) in self.m_numberTitles.enumerated()  {//找到已被选择item
                if item.isSelected {//
                    m_callLongDatas.append(item.title ?? "车长未选择")
                }
            }
            break
        case 1://思路同上🔼section==0
            m_callTypeDatas.removeAll()
            
            var typeMaxCount:NSInteger = 0
            
            for (index, item) in self.m_typeTitles.enumerated()  {
                if indexPath.row == index {
                    item.isSelected = !item.isSelected
                }
            }
            
            for (_, item) in self.m_typeTitles.enumerated()  {
                if item.isSelected {
                    typeMaxCount += 1
                }
                if typeMaxCount>3 {
                    for (index, item) in self.m_typeTitles.enumerated()  {
                        if indexPath.row == index {
                            item.isSelected = false
                        }
                    }
                    for (_, item) in self.m_typeTitles.enumerated()  {
                        if item.isSelected {//
                            m_callTypeDatas.append(item.title ?? "车长未选择")
                        }
                    }
                    print("最多可选择三个车型!")
                    return
                }
            }
            for (_, item) in self.m_typeTitles.enumerated()  {
                if item.isSelected {//
                    m_callTypeDatas.append(item.title ?? "车长未选择")
                }
            }
            break
        default:
            break
        }
        monitorSelectedDatas()
        m_collectionView.reloadData()
        
    }
    
    //MARK:监听数组已选择的数据 符合要求后改变下部按钮状态,确认选择
    func monitorSelectedDatas() {
        if !m_callLongDatas.isEmpty && !m_callTypeDatas.isEmpty {
            self.m_bottomBarView.m_color = TSColor.haimaColor.theme
            self.m_bottomBarView.m_disabled = true
        }
    }
    
    
}
extension KYCarTypeVC:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section==0 {
            return m_numberTitles.count
        }else {
            return m_typeTitles.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader{
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as? KYCarTypeHeader
            if !isSupply {
                headerView?.m_carLengthContent.text = " "
            }
            if indexPath.section == 0 {
                headerView?.m_carLength.text = "车长:"
            }else if indexPath.section == 1{
                headerView?.m_carLength.text = "车型:"
            }
            return headerView!
        }else {
            return UICollectionReusableView()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width:collectionView.frame.size.width,height:60)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KYCarTypeCell", for: indexPath) as? KYCarTypeCell
        if indexPath.section==0 {
            cell?.m_model = m_numberTitles[indexPath.row]
            
        }else if indexPath.section==1 {
            cell?.m_model = m_typeTitles[indexPath.row]
        }
        return cell!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isSupply {
            supplyDidSelectItemStatus(indexPath: indexPath)
            
        }else {
            carDidSelectItemStatus(indexPath: indexPath)
        }
        
    }
    
    
}

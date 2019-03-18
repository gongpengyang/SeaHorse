//
//  KYAddressSelectorView.swift
//  HelloWorld
//
//  Created by gongpengyang on 2019/2/25.
//  Copyright © 2019 gongpengyang. All rights reserved.
//

import UIKit
import ObjectMapper

class KYAddressSelectorView: KYBaseSheetView {
    
    override func showHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height-160
    }
    let scrWidth = UIScreen.main.bounds.size.width
    let scrheight = UIScreen.main.bounds.size.height
    
    /// 返回按钮
    @IBOutlet weak var m_backBtn: UIButton!
    
    /// 内容视图
    var m_contentScrollView: UIScrollView!
    
    //分割线
    @IBOutlet weak var m_line: UIView!
    //上部三个按钮
    @IBOutlet weak var provinceBtn: UIButton!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var areaBtn: UIButton!
    
    
    //本地地址数组(如果使用网络请求 直接赋值给该数组)
    lazy var m_datas:[KYProviceModel] = {
        () -> [KYProviceModel] in
        
        let diaryList:String = Bundle.main.path(forResource: "addressLocation", ofType:"plist")!
        var tempArr:NSArray = NSArray(contentsOfFile:diaryList)!
        
        tempArr =  Mapper<KYProviceModel>().mapArray(JSONObject: tempArr)! as NSArray
        
        return tempArr as! [KYProviceModel]
    }()
    
    //回调模型
    var m_callBackModel:KYAddressModel! = KYAddressModel()
    
    /**
     外部闭包回调
     model中存储着省市区title和code
     */
    var getAddressCallBack:((_ model:KYAddressModel) -> ())?
    
    
    
    //保存内容视图数组
    lazy var m_tableViews:[KYAddressSelectorTableView] = {
        () -> [KYAddressSelectorTableView] in
        
        var temp:Array<KYAddressSelectorTableView>! = []
        for index in 0..<3 {
            let contentTable =  KYAddressSelectorTableView.init(frame: (CGRect(x: CGFloat(index)*self.scrWidth, y: 0, width: self.scrWidth, height: self.scrheight-103-160)))//103px是top到分割线的距离
            contentTable.tableIndex = index
            contentTable.delegate = self
            temp.append(contentTable)
        }
        
        return temp
    }()
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }
    
    //MARK:展示样式初始化设置
    override func awakeFromNib() {
        
        m_line.backgroundColor = TSColor.inconspicuous.disabled
        
        provinceBtn.setTitleColor(TSColor.haimaColor.tipsColor, for: .normal)
        provinceBtn.contentHorizontalAlignment = .left
        
        cityBtn.isEnabled = false
        cityBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        cityBtn.contentHorizontalAlignment = .left
        
        areaBtn.isEnabled = false
        areaBtn.contentHorizontalAlignment = .left
        areaBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)

    }
    fileprivate  func initUI() {
        contentScrollView()
        contentTableView()
    }
    
    fileprivate  func  contentScrollView() {
        m_contentScrollView = UIScrollView()
        m_contentScrollView.frame = CGRect(x: 0, y: 103, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-103-160)
        m_contentScrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: m_contentScrollView.frame.size.height)
        m_contentScrollView.bounces = false
        m_contentScrollView.isPagingEnabled = true
        self.addSubview(m_contentScrollView)
    }
    
    fileprivate  func contentTableView() {
        
        let contentTable:KYAddressSelectorTableView = m_tableViews[0]
        contentTable.m_datas = m_datas
        m_contentScrollView.addSubview(contentTable)
        
    }
    
    
    //MARK:返回按钮(蒙版的)
    @IBAction func buttonClick(_ sender: Any) {
        
        if getAddressCallBack != nil {
            getAddressCallBack!(m_callBackModel)
        }
        self.removeFromSuperview()
        self.dismiss()
    }
    
    //MARK:上部选择地区按钮
    @IBAction func proviceBtnClick(_ sender: Any) {
        let offsetX = CGFloat(scrWidth)*0
        m_contentScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    @IBAction func cityBtnClick(_ sender: Any) {
        let offsetX = CGFloat(scrWidth)*1.0
        m_contentScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    @IBAction func areaBtnClick(_ sender: Any) {
    }
    
    //MARK:点选动态改变顶部样式
    func selectedTopContentUI(index: NSInteger) {
        switch index {
        case 0:
            //上不选中标题样式
            provinceBtn.setTitle(m_callBackModel.provice, for: .normal)
            cityBtn.isEnabled = true
            cityBtn.setTitleColor(TSColor.haimaColor.tipsColor, for: .normal)
            cityBtn.setTitle("请选择", for: .normal)
            
            areaBtn.isEnabled = false
            areaBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            areaBtn.setTitle("请选择", for: .normal)
            
            
            break
        case 1:
            cityBtn.isEnabled = true
            cityBtn.setTitleColor(TSColor.haimaColor.tipsColor, for: .normal)
            cityBtn.setTitle(m_callBackModel.city, for: .normal)
            areaBtn.isEnabled = true
            areaBtn.setTitleColor(TSColor.haimaColor.tipsColor, for: .normal)
            areaBtn.setTitle("请选择", for: .normal)
            break
        case 2:
            areaBtn.setTitleColor(TSColor.haimaColor.tipsColor, for: .normal)
            areaBtn.setTitle(m_callBackModel.area, for: .normal)
            buttonClick((Any).self)
            break
        default:
            break
        }
    }
    
    //MARK:点击后加载下一级地址内容
    func selectedContentReload(index: NSInteger,model:KYProviceModel,callModel:KYAddressModel)  {
        //根据索引号,滚动到对应页面
        //计算位移 每次点击后更新 contentSize 和 contentOffset
        //把新加入的添加新增视图对应的内容
        
        if index != 2 {
            //每次滚动到的位置
            let offsetX = CGFloat(scrWidth)*CGFloat(index+1)
            //应该赋予的contentSize.width
            let contentSizeW = CGFloat(scrWidth)*CGFloat(index+2)
            m_contentScrollView.contentSize.width = contentSizeW
            m_contentScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
            
            //视图加载
            let contentTable:KYAddressSelectorTableView = m_tableViews[index+1]
            m_contentScrollView.addSubview(contentTable)
            if (index+1)==1 {
                let model:KYProviceModel = model
                contentTable.m_datas = model.citylist
                contentTable.m_callBackModel = callModel
            }else if (index+1)==2 {
                let model:KYProviceModel =  model
                contentTable.m_datas = model.arealist
                contentTable.m_callBackModel = callModel
                
            }
        }
    }
}
// 联动委托
extension KYAddressSelectorView:KYAddressSelectorTableViewDelegate {
    func selectedToScrollOffsetTableAndCellOfIndexModel(tableIndex: NSInteger, indexPath: IndexPath, model: KYProviceModel, callModel: KYAddressModel) {
        
        //回调选择的内容
        m_callBackModel = callModel
        
        //点选动态改变顶部样式
        selectedTopContentUI(index:tableIndex)
        
        //点击后加载下一级地址内容
        selectedContentReload(index:tableIndex,model:model,callModel:callModel)
        
        
        
    }
    
}



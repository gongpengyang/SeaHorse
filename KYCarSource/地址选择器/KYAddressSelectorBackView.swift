//
//  KYAddressSelectorBackView.swift
//  KYCarSource
//
//  Created by gongpengyang on 2019/3/12.
//  Copyright © 2019 gongpengyang. All rights reserved.
//

import UIKit
import ObjectMapper

class KYAddressSelectorBackView: KYBaseSheetView {
    
    override func showHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height-160
    }
    
    /**
     外部闭包回调
     model中存储着省市区title和code
     */
    var getAddressCallBack:((_ datas:Array<KYAddressModel>) -> ())?
    
    let scrWidth = UIScreen.main.bounds.size.width
    let scrheight = UIScreen.main.bounds.size.height
    
    /// 确认按钮
    @IBOutlet weak var yesBtn: UIButton!
    
    @IBOutlet weak var m_selectedView: UIView!
    
    /// 内容视图
    var m_scrollView: UIScrollView!
    
    //分割线
    @IBOutlet weak var m_line: UIView!
    //上部三个按钮
    @IBOutlet weak var provinceBtn: UIButton!
    @IBOutlet weak var cityBtn: UIButton!
    
    
    
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
    
    /// 回调数组
    var m_callBackDatas:[KYAddressModel]! = {
        () -> [KYAddressModel] in
        var temp:Array<KYAddressModel>! = []
        let model = KYAddressModel()
        model.city = "     +     "
        temp.append(model)
        
        return temp
    }()

    /// 保存内容视图数组
    lazy var m_tableViews:[KYAddressSelectorTableView] = {
        () -> [KYAddressSelectorTableView] in
        
        var temp:Array<KYAddressSelectorTableView>! = []
        for index in 0..<2 {
            let contentTable =  KYAddressSelectorTableView.init(frame: (CGRect(x: CGFloat(index)*self.scrWidth, y: 0, width: self.scrWidth, height: self.m_scrollView.frame.size.height)))
            contentTable.tableIndex = index
            contentTable.delegate = self
            temp.append(contentTable)
        }
        
        return temp
    }()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:展示样式初始化设置
    override func awakeFromNib() {
        
        initUI()
        
        
        yesBtn.setTitleColor(TSColor.haimaColor.tipsColor, for: .normal)
        m_line.backgroundColor = TSColor.inconspicuous.disabled
        
        provinceBtn.setTitleColor(TSColor.haimaColor.firstTextColor, for: .normal)
        provinceBtn.contentHorizontalAlignment = .left
        
        cityBtn.isEnabled = false
        cityBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        cityBtn.contentHorizontalAlignment = .left
        
    }
    fileprivate  func initUI() {
        contentScrollView()
        contentTableView()
        contentBtnSelectedStyle(titles: m_callBackDatas)
    }
    
    fileprivate  func  contentScrollView() {
        m_scrollView = UIScrollView()
        m_scrollView.backgroundColor = UIColor.red
        m_scrollView.frame = CGRect(x: 0, y: m_line.frame.origin.y-15, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-(m_line.frame.origin.y)-150)
        m_scrollView.contentSize = CGSize(width: scrWidth, height: m_scrollView.frame.size.height)
        m_scrollView.bounces = false
        m_scrollView.isPagingEnabled = true
        self.addSubview(m_scrollView)
    }
    
    fileprivate  func contentTableView() {
        
        let contentTable:KYAddressSelectorTableView = m_tableViews[0]
        contentTable.m_datas = m_datas
        m_scrollView.addSubview(contentTable)
        
    }
    
    //MARK:上部选择地区按钮
    @IBAction func proviceBtnClick(_ sender: Any) {
        let offsetX = CGFloat(scrWidth)*0
        m_scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    //MARK:返回按钮(蒙版的)
    @IBAction func buttonClick(_ sender: Any) {
        
        self.removeFromSuperview()
        self.dismiss()
        
    }
    //MARK:确认按钮
    @IBAction func yesButtonClick(_ sender: Any) {
        
        for (index,item) in m_callBackDatas.enumerated() {
            if item.city == "     +     " {
                m_callBackDatas.remove(at: index)
            }
        }
        
        if getAddressCallBack != nil {
            getAddressCallBack!(m_callBackDatas)
        }
        self.removeFromSuperview()
        self.dismiss()

    }
    
    //MARK:点击城市 更新上部选中item 1 (123三个方法主要代码)
    func selectedCityClick(_ sender: Any)  {
        let model:KYAddressModel! = KYAddressModel()
        model.provice = m_callBackModel.provice
        model.proviceCode = m_callBackModel.proviceCode
        model.city = m_callBackModel.city
        model.cityCode = m_callBackModel.cityCode
        m_callBackDatas.insert(model, at: 0)
        if m_callBackDatas.count == 4 {
            m_callBackDatas.remove(at: 3)
        }
        contentBtnSelectedStyle(titles:m_callBackDatas)
        
    }
    
    /// 初始化选中后 三个按钮的frame (待改进) 2
    func contentBtnSelectedStyle(titles:Array<KYAddressModel>) {
        
        for (_,item) in m_selectedView.subviews.enumerated() {
            item.removeFromSuperview()
        }
        var firstW:Int = 0
        var secW:Int = 0
        for (index,item) in titles.enumerated() {
            
            // 设置frame
            let button = UIButton.init()
            button.setTitle(item.city, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
            button.sizeToFit()
            let btnW:Int = Int(button.frame.size.width)
            let btnH:Int = Int(button.frame.size.height)
            // 设置样式
            button.setTitleColor(TSColor.haimaColor.tipsColor, for: .normal)
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 3.0
            button.layer.borderColor = TSColor.haimaColor.tipsColor.cgColor
            button.layer.borderWidth = 1.0
            switch index {
            case 0:
                firstW = btnW
                button.frame = CGRect(x:index * btnW,y:8,width:btnW+10,height:btnH+5)
                break
                
            case 1:
                secW = btnW
                button.frame = CGRect(x:index * 25+firstW,y:8,width:btnW+10,height:btnH+5)
                break
                
            case 2:
                button.frame = CGRect(x:index * 25+secW+firstW,y:8,width:btnW+10,height:btnH+5)
                break
                
            default:
                break
                
            }
            let delBtn = UIButton.init()
            delBtn.tag = index
            delBtn.frame = CGRect(x:Int(button.frame.origin.x+button.frame.size.width-8),y:Int(button.frame.origin.y-9),width:18,height:18)
            delBtn.setBackgroundImage(#imageLiteral(resourceName: "del_btn"), for: .normal)
            delBtn.addTarget(self, action: #selector(onNextClicked), for: .touchUpInside)
            if item.city == "     +     " {
                delBtn.isHidden = true
            }
            m_selectedView.addSubview(button)
            m_selectedView.addSubview(delBtn)
            
            
        }
    }
    //MARK:删除选中item事件  3
    @objc func onNextClicked(sender: UIButton) {
        m_callBackDatas.remove(at: sender.tag)
        if m_callBackDatas.count<3 {
            var isPlus:Bool = false
            
            for (_,item) in m_callBackDatas.enumerated() {
                if item.city == "     +     " {
                    isPlus = true
                }
            }
            if !isPlus {
                let model = KYAddressModel()
                model.city = "     +     "
                m_callBackDatas.append(model)
            }
            
        }
        contentBtnSelectedStyle(titles:m_callBackDatas)
    }
    //MARK:点选动态改变顶部样式
    func selectedTopContentUI(index: NSInteger) {
        switch index {
        case 0:
            //上不选中标题样式
            self.provinceBtn.setTitle(self.m_callBackModel.provice, for: .normal)
            self.cityBtn.isEnabled = true
            self.cityBtn.setTitleColor(TSColor.haimaColor.tipsColor, for: .normal)
            self.cityBtn.setTitle("请选择", for: .normal)
            
            
            break
        case 1:
            self.cityBtn.isEnabled = true
            self.cityBtn.setTitleColor(TSColor.haimaColor.tipsColor, for: .normal)
            self.cityBtn.setTitle(self.m_callBackModel.city, for: .normal)
            selectedCityClick((Any).self)
            
            break
        case 2:
            
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
        
        if index != 1{
            //每次滚动到的位置
            let offsetX = CGFloat(ScreenWidth)*CGFloat(index+1)
            //应该赋予的contentSize.width
            let contentSizeW = CGFloat(ScreenWidth)*CGFloat(index+2)
            m_scrollView.contentSize.width = contentSizeW
            m_scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
            
            //视图加载
            let contentTable:KYAddressSelectorTableView = self.m_tableViews[index+1]
            m_scrollView.addSubview(contentTable)
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
extension KYAddressSelectorBackView:KYAddressSelectorTableViewDelegate {
    func selectedToScrollOffsetTableAndCellOfIndexModel(tableIndex: NSInteger, indexPath: IndexPath, model: KYProviceModel, callModel: KYAddressModel) {
        
        //回调选择的内容
        m_callBackModel = callModel
        
        //点选动态改变顶部样式
        selectedTopContentUI(index:tableIndex)
        
        //点击后加载下一级地址内容
        selectedContentReload(index:tableIndex,model:model,callModel:callModel)
        
        
        
    }
    
}


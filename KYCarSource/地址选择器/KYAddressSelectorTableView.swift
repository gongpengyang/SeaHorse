//
//  KYAddressSelectorTableView.swift
//  HelloWorld
//
//  Created by gongpengyang on 2019/2/26.
//  Copyright © 2019 gongpengyang. All rights reserved.
//

import UIKit

protocol KYAddressSelectorTableViewDelegate:NSObjectProtocol {
    //tableIndex:当前table索引,indexPath:当前table的cell索引  selectedDic所选的内容
    func selectedToScrollOffsetTableAndCellOfIndexModel(tableIndex:NSInteger,indexPath: IndexPath,model:KYProviceModel,callModel:KYAddressModel)
}

class KYAddressSelectorTableView: UIView,UITableViewDelegate,UITableViewDataSource {
    
    // 点击cell后 联动scrol的协议
    weak var delegate:KYAddressSelectorTableViewDelegate?
    
    // 当前tables索引
    var tableIndex:NSInteger?
    
    // 数据源
    var m_datas:[KYProviceModel]! {
        didSet {
            //每次传入数据后需要刷新一下视图,否则为上一地区二级地址
            m_tableView.reloadData()
        }
    }
    //已选择的内容
    var m_callBackModel:KYAddressModel! = KYAddressModel()


    @IBOutlet var m_contentView: UIView!
    
    
    @IBOutlet weak var m_tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)         //实现父初始化
        m_contentView = loadViewFromNib()  //从xib中加载视图
        m_contentView.frame = bounds       //设置约束或者布局
        addSubview(m_contentView)
        
        initUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        m_contentView = loadViewFromNib()
        m_contentView.frame = bounds
        addSubview(m_contentView)
        
         initUI()
        
    }
    
    fileprivate  func loadViewFromNib() -> UIView {
        
        let nib = UINib(nibName:String(describing: KYAddressSelectorTableView.self), bundle: Bundle(for:KYAddressSelectorTableView.self))
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view

    }
    override func awakeFromNib() {
        
    }
    
    fileprivate  func initUI() {
        m_tableView.delegate = self
        m_tableView.dataSource = self
        m_tableView.separatorStyle = .none
        m_tableView.register(UINib(nibName: "KYAddressSelectorTableViewCell", bundle: nil), forCellReuseIdentifier: "KYAddressSelectorTableViewCell")
        
    }
    
    
    // MARK: - tableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return m_datas?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KYAddressSelectorTableViewCell", for: indexPath) as? KYAddressSelectorTableViewCell
         cell?.m_proviceModel = m_datas?[indexPath.row]
        
        return cell!
        
    }
    
    // MARK: - didSelectRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model =  m_datas?[indexPath.row]
        for (index, item) in m_datas!.enumerated()  {
            if index==indexPath.row {
                item.isSelected = true
            }else {
                item.isSelected = false
            }
        }
        switch tableIndex {
        case 0:
            m_callBackModel.provice = model?.name
            m_callBackModel.proviceCode = model?.code
            m_callBackModel.city = nil
            m_callBackModel.cityCode = nil
            m_callBackModel.area = nil
            m_callBackModel.areaCode = nil
            
            break
        case 1:
            m_callBackModel.city = model?.name
            m_callBackModel.cityCode = model?.code
            m_callBackModel.area = nil
            m_callBackModel.areaCode = nil
            
            break
        case 2:
            m_callBackModel.area = model?.name
            m_callBackModel.areaCode = model?.code
            
            break
        default: break
            
        }
        m_tableView.reloadData()
        self.delegate?.selectedToScrollOffsetTableAndCellOfIndexModel(tableIndex: tableIndex ?? 0,indexPath: indexPath,model:model!,callModel: m_callBackModel)
        
        
    }
    
}


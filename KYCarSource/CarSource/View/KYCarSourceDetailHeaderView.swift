//
//  KYCarSourceDetailHeaderView.swift
//  HelloWorld
//
//  Created by gongpengyang on 2019/2/15.
//  Copyright © 2019 gongpengyang. All rights reserved.
//

import UIKit

class KYCarSourceDetailHeaderView: UIView {
    @IBOutlet var m_contentView: UIView!
    
    @IBOutlet weak var m_titleImageView: UIImageView!
    @IBOutlet weak var m_titleLable: UILabel!
    
    @IBOutlet weak var m_BottomLine: UIView!
    
    var buttonCallBack:(() -> ())?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)         //实现父初始化
        m_contentView = loadViewFromNib()  //从xib中加载视图
        m_contentView.frame = bounds       //设置约束或者布局
        addSubview(m_contentView)
        
        m_titleLable.textColor = TSColor.cell.titleColor
        
    }
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        m_contentView = loadViewFromNib()
        m_contentView.frame = bounds
        addSubview(m_contentView)
        
    }
    override func awakeFromNib() {
        m_titleLable.textColor = TSColor.cell.titleColor
    }
    func loadViewFromNib() -> UIView {
        //重点注意，否则使用的时候不会同步显示在IB中，只会在运行中才显示。
        //注意下面的nib加载方式直接影响是否可视化，如果bundle不确切（为nil或者为main）则看不到实时可视化
        let nib = UINib(nibName:String(describing: KYCarSourceDetailHeaderView.self), bundle: Bundle(for:KYCarSourceDetailHeaderView.self))
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        loadViewTapGesture(view: view)
        return view
    }
    func loadViewTapGesture(view:UIView) {
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapGestureClick))
        view.addGestureRecognizer(tapGesture)
    }
   @objc func tapGestureClick() {
    if buttonCallBack != nil {
        buttonCallBack!()
    }
    }

}

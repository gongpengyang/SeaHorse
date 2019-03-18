//
//  KYBottomBarView.swift
//  HelloWorld
//
//  Created by gongpengyang on 2019/2/14.
//  Copyright © 2019 gongpengyang. All rights reserved.
// 底部提交,保存button

import UIKit

class KYBottomBarView: UICollectionReusableView {
    
    private var m_button:UIButton?
    var buttonCallBack:(() -> ())?
    let m_width = UIScreen.main.bounds.width
    
    /** 自定义标题 */
    var m_title: String?{
        didSet {
            m_button?.setTitle(m_title, for: .normal)
        }
    }
    /** 自定义颜色 */
    var m_color: UIColor?{
        didSet {
           m_button?.backgroundColor = m_color
        }
    }
    /** 自定义交互 */
    var m_disabled:Bool?{
        didSet {
            m_button?.isEnabled = m_disabled ?? true
        }
    }
    
    
    
    override init(frame:CGRect){
        if frame.size.width>0 {
            super.init(frame: frame)
        }else {
                  super.init(frame: CGRect(x:0, y:0, width:m_width, height:100))
        }
        setupSubViews()
    }
    
    //Swift在类初始化时，出于对安全性的考虑，对类的所有内部属性必须全部被初始化(通俗一点就是分配一个默认值) xib使用
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    func setupSubViews() {
        
        self.backgroundColor = UIColor.clear
        m_button = UIButton(frame: CGRect(x:15,y:30,width:m_width-30,height:45))
        m_button?.backgroundColor = TSColor.haimaColor.theme
        m_button?.setTitleColor(UIColor.black, for: .normal)
        m_button?.layer.masksToBounds = true
        m_button?.layer.cornerRadius = 3.0
        m_button?.setTitle("保存", for: .normal)
        m_button?.addTarget(self, action: #selector(onNextClicked), for: .touchUpInside)
        self.addSubview(m_button!)
        
  
       
    }
    
    @objc func onNextClicked() {
        if buttonCallBack != nil {
            buttonCallBack!()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
}

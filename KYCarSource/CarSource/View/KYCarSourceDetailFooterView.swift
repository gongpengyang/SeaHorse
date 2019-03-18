//
//  KYCarSourceDetailFooterView.swift
//  HelloWorld
//
//  Created by gongpengyang on 2019/2/18.
//  Copyright © 2019 gongpengyang. All rights reserved.
//

import UIKit

class KYCarSourceDetailFooterView: UIView {

    @IBOutlet var m_contentView: UIView!
    
    @IBOutlet weak var m_rightImageView: UIImageView!
    @IBOutlet weak var m_titleLable: UILabel!
 
    
    var buttonCallBack:(() -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)         //实现父初始化
        m_contentView = loadViewFromNib()  //从xib中加载视图
        m_contentView.frame = bounds       //设置约束或者布局
        addSubview(m_contentView)
        
    }
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        m_contentView = loadViewFromNib()
        m_contentView.frame = bounds
        addSubview(m_contentView)
        
    }
    func loadViewFromNib() -> UIView {
        let nib = UINib(nibName:String(describing: KYCarSourceDetailFooterView.self), bundle: Bundle(for:KYCarSourceDetailFooterView.self))
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

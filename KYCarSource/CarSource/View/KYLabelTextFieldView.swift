//
//  KYLabelTextFieldView.swift
//  HelloWorld
//
//  Created by gongpengyang on 2019/2/18.
//  Copyright © 2019 gongpengyang. All rights reserved.
//

import UIKit

class KYLabelTextFieldView: UIView {

    @IBOutlet var m_contentView: UIView!
    
    @IBOutlet weak var m_rightImageView: UIImageView!
    @IBOutlet weak var m_titleLable: UILabel!
    @IBOutlet weak var m_topLine: UIView!
    @IBOutlet weak var m_bottomLine: UIView!
    @IBOutlet weak var m_textField: UITextField!
   
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        m_contentView = loadViewFromNib()
        m_contentView.frame = bounds
        addSubview(m_contentView)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        m_contentView = loadViewFromNib()
        m_contentView.frame = bounds
        addSubview(m_contentView)
        
    }
    func loadViewFromNib() -> UIView {
        let nib = UINib(nibName:String(describing: KYLabelTextFieldView.self), bundle: Bundle(for:KYLabelTextFieldView.self))
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}

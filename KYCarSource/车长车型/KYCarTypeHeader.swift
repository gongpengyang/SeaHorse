//
//  KYCarTypeHeader.swift
//  KYCarSource
//
//  Created by gongpengyang on 2019/3/7.
//  Copyright © 2019 gongpengyang. All rights reserved.
//

import UIKit

class KYCarTypeHeader: UICollectionReusableView {
    
    
    @IBOutlet weak var m_carLength: UILabel!
    

    @IBOutlet weak var m_carLengthContent: UILabel!
    
    @IBOutlet var m_contentView: UIView!
    
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
    override func awakeFromNib() {

    }
    func loadViewFromNib() -> UIView {
        let nib = UINib(nibName:String(describing: KYCarTypeHeader.self), bundle: Bundle(for:KYCarTypeHeader.self))
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

}

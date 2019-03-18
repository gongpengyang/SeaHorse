//
//  KYCarTypeCell.swift
//  KYCarSource
//
//  Created by gongpengyang on 2019/3/7.
//  Copyright © 2019 gongpengyang. All rights reserved.
//

import UIKit

class KYCarTypeCell: UICollectionViewCell {
    
    
    @IBOutlet weak var m_title: UILabel!
    
    var m_model:KYCarTypeModel? {
        didSet {
            if m_model?.isSelected ?? false{
                m_title.backgroundColor = TSColor.haimaColor.theme
            }else {
                m_title.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            m_title.text = m_model?.title
        }
    }

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        m_title.textColor = TSColor.normal.blackTitle
        m_title.layer.masksToBounds = true
        m_title.layer.cornerRadius = 3.0
        m_title.layer.borderWidth = 1.0
        m_title.layer.borderColor = TSColor.cell.tintLine.cgColor
    }

}

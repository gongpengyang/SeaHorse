//
//  KYAddressSelectorTableViewCell.swift
//  HelloWorld
//
//  Created by gongpengyang on 2019/3/4.
//  Copyright © 2019 gongpengyang. All rights reserved.
//

import UIKit

class KYAddressSelectorTableViewCell: UITableViewCell {

    @IBOutlet weak var m_tittleLable: UILabel!
    
    var m_proviceModel:KYProviceModel? {
        didSet {
            if m_proviceModel?.isSelected ?? false{
                m_tittleLable.textColor = TSColor.haimaColor.tipsColor
            }else {
                m_tittleLable.textColor = TSColor.normal.blackTitle
            }
          m_tittleLable.text =  m_proviceModel?.name
        }
    }

    @IBOutlet weak var m_line: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        m_tittleLable.textColor = TSColor.normal.blackTitle
        m_line.backgroundColor = TSColor.inconspicuous.disabled
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

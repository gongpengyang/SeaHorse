//
//  KYCarSourceDetailCell.swift
//  HelloWorld
//
//  Created by gongpengyang on 2019/2/18.
//  Copyright © 2019 gongpengyang. All rights reserved.
//

import UIKit

class KYCarSourceDetailCell: UITableViewCell {
    
    @IBOutlet weak var m_titleLable: UILabel!
    
    @IBOutlet weak var m_contentLabel: UITextField!
    
    @IBOutlet weak var m_rightImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        m_titleLable.textColor = TSColor.cell.titleColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
 
}

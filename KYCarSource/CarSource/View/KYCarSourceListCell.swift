//
//  KYCarSourceListCell.swift
//  HelloWorld
//
//  Created by gongpengyang on 2019/2/13.
//  Copyright © 2019 gongpengyang. All rights reserved.
//

import UIKit

class KYCarSourceListCell: UITableViewCell {
    
    var buttonCallBack:(() -> ())?
 
    
    @IBOutlet weak var m_contentView: UIView!
    
    @IBOutlet weak var m_leftImageVIew: UIImageView!
    
    @IBOutlet weak var m_rightImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    //左侧蒙版btn
    @IBAction func coverButtonClick(_ sender: Any) {
        if buttonCallBack != nil {
            buttonCallBack!()
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

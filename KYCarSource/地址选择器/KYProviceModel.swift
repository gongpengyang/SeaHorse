//
//  KYProviceModel.swift
//  HelloWorld
//
//  Created by gongpengyang on 2019/3/5.
//  Copyright © 2019 gongpengyang. All rights reserved.
//

import UIKit
import ObjectMapper

//省份,城市,地区 使用一个模型做接收,控件之间传值方便一些
class KYProviceModel: Mappable {
    
    var name:String?
    var code:String?
    var citylist:[KYProviceModel]?
    var arealist:[KYProviceModel]?
    
    //判断是否选择布尔
    var isSelected:Bool?
    
    
    required init?(map:Map) {
        
    }
    
    func mapping(map:Map)  {
        name   <- map["name"]
        code   <- map["code"]
        citylist   <- map["citylist"]
        arealist <- map["arealist"]
        
        
        isSelected   <- map["isSelected"]
        
        
    }
    
}


//
//  KYCarSourceModel.swift
//  ThinkSNSPlus
//
//  Created by gongpengyang on 2019/2/20.
//  Copyright © 2019 ZhiYiCX. All rights reserved.
//

import UIKit
import ObjectMapper

class KYCarSourceModel: Mappable {
    var username: String?
    var age: Int?
    var weight: Double!
    var array: [Any]?
    var dictionary: [String : Any] = [:]
//    var bestFriend: User?                       // Nested User object
//    var friends: [User]?                        // Array of Users
    var birthday: Date?
    
    required init?(map: Map) {
        
    }
    // Mappable
    func mapping(map: Map) {
        username    <- map["username"]
        age         <- map["age"]
        weight      <- map["weight"]
        array       <- map["arr"]
        dictionary  <- map["dict"]
//        bestFriend  <- map["best_friend"]
//        friends     <- map["friends"]
        birthday    <- (map["birthday"], DateTransform())
    }

}

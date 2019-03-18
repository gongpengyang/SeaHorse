//
//  KYNetworkReachability.swift
//  HelloWorld
//
//  Created by gongpengyang on 2019/2/15.
//  Copyright © 2019 gongpengyang. All rights reserved.
//

import UIKit
import Alamofire


class KYNetworkReachability: NSObject {

    static let reachAbility = KYNetworkReachability()
    
    var reachAble:Bool = {
        var reach = true
        
        let manager = NetworkReachabilityManager(host: "www.baidu.com")
        
        manager?.listener = { status in
            switch status {
            case .notReachable:
                reach = false
//                SVProgressHUD.showError(withStatus: "网络出错")
            case .reachable(.ethernetOrWiFi):
                reach = true
            case .reachable(.wwan):
                reach = true
            case .unknown:
                reach = false
//                SVProgressHUD.showError(withStatus: "网络出错")
            }
        }
        manager?.startListening()
        
        return reach
    }()
    
}

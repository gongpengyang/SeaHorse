//
//  KYSourceTaskManager.swift
//  ThinkSNSPlus
//
//  Created by gongpengyang on 2019/2/20.
//  Copyright © 2019 ZhiYiCX. All rights reserved.
//

import UIKit
import RealmSwift
import ReachabilitySwift


class KYSourceTaskManager: NSObject {
    
    //外部只负责调取方法 拿到整理好的返回数据
    
    /** 车源列表 */
    func getCarSourceListData(complete: @escaping((_ info: [KYCarSourceModel]?, _ error: Error?) -> Void)) {
        KYSourceNetWorkManager.getNewsListData(tagID: 1, maxID: 1, limit: TSAppConfig.share.localInfo.limit, isCheckCommend: false) { (carModels, error) in
            if error == nil {
                complete(carModels, nil)
            } else {
                complete(nil, error)
            }
        }
    }

}

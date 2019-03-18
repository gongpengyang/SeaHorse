//
//  KYSourceNetWorkManager.swift
//  ThinkSNSPlus
//
//  Created by gongpengyang on 2019/2/20.
//  Copyright © 2019 ZhiYiCX. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class KYSourceNetWorkManager: NSObject {
    
    
    // MARK: - 资讯列表
    
    /// 获取资讯列表数据,搜索资讯列表
    ///
    /// - Parameters:
    ///   - tagID: 栏目id.在isCheckCommend 为true时,该id无效
    ///   - maxID: 末尾数据id （用于加载更多）
    ///   - isCheckCommend: 是否抓取推荐信息
    ///   - searchKey: 搜索关键字,可以和tagID,maxID,isCheckCommend等组合搜索
    ///   - complate: 结果
    
    class func getNewsListData(tagID: Int, maxID: Int?, limit: Int?, isCheckCommend: Bool = false, searchKey: String? = nil, complete: @escaping((_ info: [KYCarSourceModel]?, _ error: Error?) -> Void)) {
        let requestMethod = KYSourceNetWorkRequest().getCarSource
        var parameter: Dictionary<String, Any> = [:]
//        parameter["cate_id"] = tagID
//        if let maxID = maxID {
//            parameter["after"] = maxID
//        }
//        if let limit = limit {
//            parameter["limit"] = limit
//        }
//        if isCheckCommend == true {
//            // 当检索推荐信息时,撤销别的请求参数,保证返回所有的推荐信息,组成推荐页面
//            parameter.removeValue(forKey: "cate_id")
//            parameter.removeValue(forKey: "key")
//            parameter["recommend"] = 1
//        }
//        if let searchKey = searchKey {
//            // 当搜索资讯时,撤销别的请求参数,保证搜索所有的信息,组成搜索页面
//            parameter.removeValue(forKey: "cate_id")
//            parameter.removeValue(forKey: "recommend")
//            parameter["key"] = searchKey
//        }
        try! RequestNetworkData.share.textRequest(method: requestMethod.method, path: requestMethod.fullPath(), parameter: parameter, complete: { (networkResponse, result) in
            guard result else {
                complete(nil, TSErrorCenter.create(With: .networkError))
                return
            }

            guard let carModels = Mapper<KYCarSourceModel>().mapArray(JSONObject: networkResponse) else {
                assert(false, "返回了无法解析的数据")
                complete(nil, TSErrorCenter.create(With: .networkError))
                return
            }
            complete(carModels, nil)
        })
    }


}

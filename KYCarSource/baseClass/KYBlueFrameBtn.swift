//
//  KYMainYellowBtn.swift
//  OCAlertToSwift
//
//  Created by mac on 2019/2/15.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
/// 蓝框按钮  http://172.16.201.25/qingyidai_UI/APP/%E6%B5%B7%E9%A9%AC%E8%81%8A%E5%A4%A91.0%E7%89%88%E6%9C%AC%E3%80%82/#artboard40
class KYBlueFrameBtn: TSButton {
    override var isHighlighted: Bool {
        get {
            return false
        }
        set {}
    }
    private func configUI() {
        let corner: CGFloat = 4.0
        clipsToBounds = true
        layer.cornerRadius = corner
        let blueColor = UIColor(hex: 0x59bfff)
        setTitleColor(blueColor, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        layer.borderColor = blueColor.cgColor
        layer.borderWidth = 1.0
        if widthConstraint == nil && heightConstraint == nil {
            contentEdgeInsets  = UIEdgeInsetsMake(6, 10, 6, 9)
        }
        /// 禁用状态下颜色改变
//        let disableStatusChangeColor = true
//        if (disableStatusChangeColor) {
            //            setTitleColor(UIColor.black, for: .disabled)
            //            let norImg = image(color: UIColor.yellow)
            //            setBackgroundImage(norImg, for: .normal)
//        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configUI()
    }
    // MARK: - 可抽取或调用外部方法
    private func image(color: UIColor, frame: CGRect) -> UIImage {
        UIGraphicsBeginImageContext(frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        context.setFillColor(color.cgColor)
        context.fill(frame)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
    private func image(color: UIColor) -> UIImage {
        return image(color: color, frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    }
}
